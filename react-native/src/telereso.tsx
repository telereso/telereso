import {Asset} from 'expo-asset';
import remoteConfig, {FirebaseRemoteConfigTypes} from '@react-native-firebase/remote-config';
import messaging, {FirebaseMessagingTypes} from '@react-native-firebase/messaging';
import i18n from 'i18n-js';

const TAG = 'Telereso';
const TAG_STRINGS = `${TAG}_strings`;
const TAG_DRAWABLE = `${TAG}_drawable`;
const STRINGS = "strings";
const DRAWABLE = "drawable";

let isLogEnabled = true;
let isStringLogEnabled = false;
let isDrawableLogEnabled = false;
let isRealTimeChangesEnabled = false;
let remoteConfigSettings: FirebaseRemoteConfigTypes.ConfigSettings;

let currentLocal = "en";
let defaultLocal = "en";

let stringsMap: { [locale: string]: { [key: string]: string } } = {};
let drawableMap: { [key: string]: string } = {};

let remoteChangesListeners: { (): void; }[] = [];


function log(log: string) {
    if (isLogEnabled)
        console.log(`${TAG}: ` + log);
}

function logStrings(log: string) {
    if (isStringLogEnabled)
        console.log(`${TAG_STRINGS}: ` + log);
}

function logDrawable(log: string) {
    if (isDrawableLogEnabled)
        console.log(`${TAG_DRAWABLE}: ` + log);
}

function initMap() {
    // strings
    var json = remoteConfig().getString(STRINGS)
    if (!json || json.length == 0) {
        json = "{}";
        logStrings(`Default local ${STRINGS} was not found`)
    }
    stringsMap[STRINGS] = JSON.parse(json);


    var localId = getStringsId(currentLocal);
    json = remoteConfig().getString(localId);
    if (!json || json.length == 0) {
        json = "{}";
        logStrings(`Local ${localId} was not found`)
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
                    logStrings(`Local ${key} was empty`)
                }
                stringsMap[key] = JSON.parse(json);
            }
        });
    } else {
        log("Remote config was empty!");
    }

    let remoteLocalization: { [locale: string]: any } = {};
    for (let local in i18n.translations) {
        remoteLocalization[local] = i18n.translations[local];
    }

    for (let remoteId in stringsMap) {
        let local = remoteId == STRINGS ? defaultLocal : remoteId.split("_")[1];
        for (let key in stringsMap[remoteId]) {
            let value = stringsMap[remoteId][key];
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

async function fetchResources() {
    await remoteConfig().setConfigSettings(remoteConfigSettings ?? isRealTimeChangesEnabled ? {minimumFetchIntervalMillis: 1,} : {});
    let fetchedRemotely = await remoteConfig().fetchAndActivate();
    if (fetchedRemotely) {
        log("Remote changed, updating...")
        await asyncInitMap();
        remoteChangesListeners.forEach(l => {
            l()
        });
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

function subscriptToRemoteChanges() {
    log("Subscribe to changes")
    messaging().subscribeToTopic('TELERESO_PUSH_RC');
}

export namespace Telereso {

    export function init(defaultLocal: { currentLocale: () => string; }) {
        log("Initializing...");
        currentLocal = defaultLocal.currentLocale();
        currentLocal = currentLocal.split("-")[0];


        remoteConfig().activate().then(() => {
            initMap();
            log("Initialized");
        });

        fetchResources();

        if (isRealTimeChangesEnabled)
            subscriptToRemoteChanges()

        return Telereso
    }

    export async function suspendedInit(defaultLocal: { currentLocale: () => string; }) {
        log("Initializing...");

        currentLocal = defaultLocal.currentLocale();
        currentLocal = currentLocal.split("-")[0];

        await remoteConfig().setConfigSettings(remoteConfigSettings ?? isRealTimeChangesEnabled ? {minimumFetchIntervalMillis: 1,} : {});
        await remoteConfig().fetchAndActivate();
        await asyncInitMap();

        if (isRealTimeChangesEnabled)
            subscriptToRemoteChanges()

        log("Initialized");
    }

    export function getRemoteImage(key: string): string {
        logDrawable(`********************** ${key} **********************`);
        const url = drawableMap[key]
        if (!url) {
            logDrawable("Did not find in " + DRAWABLE);
        }
        logDrawable(`url: ${key}`);
        logDrawable("***********************************************************");
        return url;
    }

    export function getRemoteImageOrDefault(resource: number): string {
        let assetUri = Asset.fromModule(resource).uri;
        let segments = assetUri.split('assets');
        let key = segments[segments.length - 1].split("?")[0];
        if (key.startsWith("/"))
            key = key.substring(1);
        let imageUri = Telereso.getRemoteImage(key);
        if (!imageUri)
            imageUri = assetUri;
        return imageUri;
    }

    export function handleRemoteMessage(remoteMessage: FirebaseMessagingTypes.RemoteMessage): boolean {
        if (remoteMessage['data'] && remoteMessage['data']['TELERESO_CONFIG_STATE']) {
            log("Remote updated")
            if (isRealTimeChangesEnabled)
                fetchResources();
            return true;
        }
        return false;
    }

    export function addRemoteChangeListener(callback: { (): void; (): void; }) {
        remoteChangesListeners.push(callback);
    }

    export function removeRemoteChangeListener(callback: { (): void; (): void; }) {
        remoteChangesListeners = remoteChangesListeners.filter(listener => listener !== callback);
    }

    export function disableLog() {
        isLogEnabled = false
        return Telereso
    }

    export function enableStringsLog() {
        isStringLogEnabled = true
        return Telereso
    }

    export function enableDrawableLog() {
        isDrawableLogEnabled = true
        return Telereso
    }

    export function enableRealTimeChanges() {
        isRealTimeChangesEnabled = true
        return Telereso
    }

    export function setRemoteConfigSettings(settings: FirebaseRemoteConfigTypes.ConfigSettings) {
        remoteConfigSettings = settings
        return Telereso
    }


}
