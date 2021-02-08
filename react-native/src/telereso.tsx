import { Asset } from 'expo-asset';
import remoteConfig from '@react-native-firebase/remote-config';
import messaging, { FirebaseMessagingTypes } from '@react-native-firebase/messaging';
import i18n from 'i18n-js';

const TAG = 'TELERESO';
const TAG_STRINGS = `${TAG}_STRINGS`;
const TAG_DRAWABLE = `${TAG}_DRAWABLE`;
const STRINGS = "strings";
const DRAWABLE = "drawable";

let isLogEnabled = true;
let isStringLogEnabled = true;
let isDrableLogEnabled = true;

let currentLocal = "en";
let defaultLocal = "en";

let stringsMap: { [locale: string]: { [key: string]: string } } = {};
let drawableMap: { [key: string]: string } = {};

let remoteChangesLisnters: { (): void; }[] = [];


function log(log: string) {
    if (isLogEnabled)
        console.log(`${TAG}: ` + log);
}

function logStrings(log: string) {
    if (isStringLogEnabled)
        console.log(`${TAG_STRINGS}: ` + log);
}

function logDrawable(log: string) {
    if (isDrableLogEnabled)
        console.log(`${TAG_DRAWABLE}: ` + log);
}

function initMap() {
    // strings
    var json = remoteConfig().getString(STRINGS)
    if (!json || json.length == 0) {
        json = "{}";
        logStrings(`default local ${STRINGS} was not found`)
    }
    stringsMap[STRINGS] = JSON.parse(json);


    var localId = getStringsId(currentLocal);
    json = remoteConfig().getString(localId);
    if (!json || json.length == 0) {
        json = "{}";
        logStrings(`local ${localId} was not found`)
    }
    stringsMap[localId] = JSON.parse(json);

    const all = remoteConfig().getAll();
    if (all) {
        Object.entries(all).forEach(($) => {
            const [key, entry] = $;
            if (key.startsWith(STRINGS) && key != STRINGS && key != localId) {
                json = entry.asString();
                if (!json || json.length == 0) {
                    json = "{}";
                    logStrings(`local ${key} was empy`)
                }
                stringsMap[key] = JSON.parse(json);
            }
        });
    } else {
        log("remote config was empty!");
    }

    var remoteLocalization: { [locale: string]: any } = {};
    for (var local in i18n.translations) {
        remoteLocalization[local] = i18n.translations[local];
    }

    for (var remoteId in stringsMap) {
        let local = remoteId == STRINGS ? defaultLocal : remoteId.split("_")[1];
        for (var key in stringsMap[remoteId]) {
            var value = stringsMap[remoteId][key];
            if (remoteLocalization[local]) {
                remoteLocalization[local][key] = value;
            } else {
                remoteLocalization[local] = stringsMap[remoteId]
            }
        }
    }

    i18n.translations = remoteLocalization;

    // drawables
    json = remoteConfig().getString(DRAWABLE);
    if (!json || json.length == 0) {
        json = "{}";
    }
    drawableMap = JSON.parse(json);

    // Image.prefetch("");
    // Asset.fromModule(a).downloadAsync();
}

async function fetchResrouces() {
    await remoteConfig().setConfigSettings({ minimumFetchIntervalMillis: 1, });
    var fetchedRemotely = await remoteConfig().fetchAndActivate();
    if (fetchedRemotely) {
        log("Remote changed, updating...")
        await asyncInitMap();
        remoteChangesLisnters.forEach(l => { l() });
    }
}

async function asyncInitMap() {
    await initMap();
}

function getStringsId(local: string) {
    return `${STRINGS}_${local}`;
}

function getDrawableId(size: string) {
    return `${DRAWABLE}_${size}`;
}

export namespace Telereso {
    export function init(defaultLocal: { currentLocale: () => string; }) {
        log("Telereso initilaizing...");
        currentLocal = defaultLocal.currentLocale();
        currentLocal = currentLocal.split("-")[0];


        remoteConfig().activate().then(() => {
            initMap();
            log("Telereso initilaized");
        });

        fetchResrouces();

    }

    export async function suspendedInit(defaultLocal: { currentLocale: () => string; }) {
        log("Telereso initilaizing...");

        currentLocal = defaultLocal.currentLocale();
        currentLocal = currentLocal.split("-")[0];

        await remoteConfig().setConfigSettings({ minimumFetchIntervalMillis: 1, });
        await remoteConfig().fetchAndActivate();
        await asyncInitMap();


        log("Telereso initilaized");
    }

    export function getRemoteImage(key: string): string {
        const url = drawableMap[key]
        if (!url) {
            logDrawable("did not find remote " + key);
        }
        return url;
    }

    export function getRemoteImageOrDefault(resource: number): string {
        var assetUri = Asset.fromModule(resource).uri;
        var segments = assetUri.split('assets');
        var key = segments[segments.length - 1].split("?")[0];
        if (key.startsWith("/"))
            key = key.substring(1);
        var imageUri = Telereso.getRemoteImage(key);
        if (!imageUri)
            imageUri = assetUri;
        return imageUri;
    }

    export function handleRemoteMessage(remoteMessage: FirebaseMessagingTypes.RemoteMessage): boolean {
        if (remoteMessage['data'] && remoteMessage['data']['TELERESO_CONFIG_STATE']) {
            fetchResrouces();
            return true;
        }
        return false;
    }

    export function subscriptToRemoteChanges() {
        log("subscring to changes")
        messaging().subscribeToTopic('TELERESO_PUSH_RC');
    }

    export function addRemoteChangeListner(callback: { (): void; (): void; }) {
        remoteChangesLisnters.push(callback);
    }

    export function removeRemoteChangeListner(callback: { (): void; (): void; }) {
        remoteChangesLisnters = remoteChangesLisnters.filter(listener => listener !== callback);
    }


}