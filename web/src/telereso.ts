import fb from 'firebase/app';
import 'firebase/remote-config';
import 'firebase/messaging';

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
    if (isDrableLogEnabled)
        console.log(`${TAG_DRAWABLE}: ` + log);
}

function getStringsId(local: string) {
    return `${STRINGS}_${local}`;
}

// function getDrawableId(size: string) {
//     return `${DRAWABLE}_${size}`;
// }

class TeleresoSingleton {

    remoteConfig: fb.remoteConfig.RemoteConfig | undefined;
    i18n: any | undefined;

    init(i18n: any, firebase: any) {
        this.remoteConfig = firebase.remoteConfig();
        this.i18n = i18n;

        log("Telereso initializing...");
        currentLocal = i18n.currentLocale();
        currentLocal = currentLocal.split("-")[0];

        this.remoteConfig.activate().then(() => {
            this.initMap();
            log("Telereso initialized");
        });

        this.fetchResources();

    }

    async suspendedInit(i18n: any, firebase: any) {
        this.remoteConfig = firebase.remoteConfig();
        this.i18n = i18n;

        log("Telereso initializing...");

        currentLocal = i18n.currentLocale();
        currentLocal = currentLocal.split("-")[0];

        this.remoteConfig!.settings.minimumFetchIntervalMillis = 1
        await this.remoteConfig!.fetchAndActivate();
        await this.asyncInitMap();


        log("Telereso initialized");
    }

    initMap() {
        if (!this.i18n) {
            log("please provide a proper i18n in init")
            return
        }
        // strings
        let json = this.remoteConfig?.getString(STRINGS)
        if (!json || json.length == 0) {
            json = "{}";
            logStrings(`default local ${STRINGS} was not found`)
        }
        stringsMap[STRINGS] = JSON.parse(json);


        let localId = getStringsId(currentLocal);
        json = this.remoteConfig?.getString(localId);
        if (!json || json.length == 0) {
            json = "{}";
            logStrings(`local ${localId} was not found`)
        }
        stringsMap[localId] = JSON.parse(json);

        const all = this.remoteConfig?.getAll();
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

        let remoteLocalization: { [locale: string]: any } = {};
        for (let local in this.i18n?.translations) {
            remoteLocalization[local] = this.i18n?.translations[local];
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

        console.log()
        this.i18n.translations = remoteLocalization;

        // drawables
        json = this.remoteConfig?.getString(DRAWABLE);
        if (!json || json.length == 0) {
            json = "{}";
        }
        drawableMap = JSON.parse(json);

        // Image.prefetch("");
    }

    async fetchResources() {
        this.remoteConfig!.settings.minimumFetchIntervalMillis = 1
        let fetchedRemotely = await this.remoteConfig?.fetchAndActivate();
        if (fetchedRemotely) {
            log("Remote changed, updating...")
            await this.asyncInitMap();
            remoteChangesListeners.forEach(l => {
                l()
            });
        }
    }

    async asyncInitMap() {
        await this.initMap();
    }


    getRemoteImageOrDefault(resource: string): string {
        let assetUri = resource
        let segments = assetUri.split('/');
        let keyPart = segments[segments.length - 1].split(".");
        let key = keyPart[0] + "." + keyPart[keyPart.length - 1]
        let imageUri = this.getRemoteImage(key);
        if (!imageUri)
            imageUri = assetUri;
        return imageUri;
    }

    getRemoteImage(key: string): string {
        const url = drawableMap[key]
        if (!url) {
            logDrawable("did not find remote " + key);
        }
        return url;
    }

    handleRemoteMessage(remoteMessage: any): boolean {
        if (remoteMessage['data'] && remoteMessage['data']['TELERESO_CONFIG_STATE']) {
            this.fetchResources();
            return true;
        }
        return false;
    }

    addRemoteChangeListener(callback: { (): void; (): void; }) {
        remoteChangesListeners.push(callback);
    }

    removeRemoteChangeListener(callback: { (): void; (): void; }) {
        remoteChangesListeners = remoteChangesListeners.filter(listener => listener !== callback);
    }
}

export const Telereso = new TeleresoSingleton();
