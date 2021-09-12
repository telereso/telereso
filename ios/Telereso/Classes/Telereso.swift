
import FirebaseRemoteConfig
import SwiftyJSON


internal let TAG = "Telereso"
internal let TAG_STRINGS = "\(TAG)_strings"
internal let TAG_DRAWABLES = "\(TAG)_drawable"
private let STRINGS = "strings"
private let DRAWABLE = "drawable"

public struct Telereso{
    @available(*, unavailable) private init() {}

    static private var isLogEnabled = true
    static private var isStringLogEnabled = false
    static private var isDrawableLogEnabled = false
    static private var _isRealTimeChangesEnabled = false
    
    //    private var listenersList = hashSetOf<RemoteChanges>()
    static private var stringsMap = [String : [String : JSON]]()
    static private var currentLocal: String?
    //    private var drawableMap = HashMap<String, JSONObject>()
    //    private var densityList = listOf("ldpi", "mdpi", "hdpi", "xhdpi", "xxhdpi", "xxxhdpi")
    //
    
    static private var remoteConfigSettings: RemoteConfigSettings?
    static private var remoteConfig: RemoteConfig!
        
    static public func initialize(completionHandler: (() -> Void)? = nil){
        log("Initializing...")
        
        remoteConfig = RemoteConfig.remoteConfig()
        var settings = remoteConfigSettings
        if(settings == nil){
            let s = RemoteConfigSettings()
            if(_isRealTimeChangesEnabled){
                s.minimumFetchInterval = 0
            }
            settings = s
        }
        remoteConfig.configSettings = settings!
        
        
        fetchResource(){ (shouldUpdate) -> Void in
            if(shouldUpdate){
                self.log("Fetched new data")
                self.initMaps()
            }
            completionHandler?()
        }
        
        initMaps()
        
        log("Initialized!")
    }
    
    static public func setRemoteConfigSettings(_ remoteConfigSettings: RemoteConfigSettings) -> Telereso.Type {
        self.remoteConfigSettings = remoteConfigSettings;
        return self
    }
    
    static public func enableStringLog() -> Telereso.Type {
        isStringLogEnabled = true
        return self
    }
    
    static public func enableDrawableLog() -> Telereso.Type {
        isDrawableLogEnabled = true
        return self
    }
    
    static public func disableLog() -> Telereso.Type {
        isLogEnabled = false
        return self
    }
    
    static public func enableRealTimeChanges() -> Telereso.Type {
        _isRealTimeChangesEnabled = true
        subscriptToChanges()
        return self
    }
    
    static public func getRemoteStringOrDefault(_ local: String,_ key: String,_ defaultValue: String? = nil) -> String {
        logStrings("******************** \(key) ********************")
        let value = getStringValue(local, key, defaultValue)
        logStrings("local:\(local) default:\(defaultValue ?? "") value:\(value)")
        if (value.isEmpty) {
            logStrings("\(key) was empty in \(getStringKey(local)) and \(STRINGS) and local strings",true)
            onResourceNotFound(key)
        }
        logStrings("*************************************************")
        return value
    }
    
    static public func getRemoteString(_ key:String,_ comment:String = "") -> String{
        return getRemoteStringOrDefault(getLocal(), key, NSLocalizedString(key, comment: comment))
    }
    
    static private func fetchResource(completionHandler: ((Bool) -> Void)? = nil) {
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                self.log("Config fetched!")
                self.remoteConfig.activate { changed, error in
                    completionHandler?(changed)
                }
            } else {
                self.log("Config not fetched")
                self.log("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
    
    static private func initMaps(){
        //  strings
        
        let defaultString = remoteConfig.configValue(forKey: STRINGS).jsonValue
        var defaultJson :[String : JSON]
        
        if (defaultString == nil) {
            defaultJson = JSON.init(parseJSON:"{}").dictionary ?? [:]
            log("Your default local \(STRINGS) was not found in remote config", true)
        } else {
            log("Default local \(STRINGS) was setup")
            defaultJson = JSON(defaultString!).dictionary ?? [:]
        }
        stringsMap[STRINGS] = defaultJson
        
        let deviceLocal = getLocal()
        currentLocal = deviceLocal
        
        let local = getRemoteLocal(deviceLocal)
        
        stringsMap[getStringKey(deviceLocal)] = JSON.init(parseJSON:local).dictionary ?? [:]
        
    }
    
    static private func getLocal() -> String{
        return Bundle.main.preferredLocalizations.first ?? "en"
    }
    
    static private func getRemoteLocal(_ deviceLocal: String) -> String {
        var local = remoteConfig.configValue(forKey: getStringKey(deviceLocal)).stringValue ?? ""
        if (local.isEmpty) {
            let baseLocal = deviceLocal.split{$0 == "_"}[0].base
            log("The app local \(deviceLocal) was not found in remote config will try \(baseLocal)")
            let key = remoteConfig.keys(withPrefix: getStringKey(baseLocal)).first
            if (key == nil) {
                log("\(baseLocal) was not found as well")
            } else {
                if (key!.contains("off")){
                    log("\(baseLocal) was found but it was turned off, remove _off suffix to enable it")
                } else {
                    local = remoteConfig.configValue(forKey: key).stringValue ?? ""
                }
            }
        }
        if (local.isEmpty) {
            local = "{}"
            log("The app local \(deviceLocal) was not found in remote config", true)
        } else {
            log("device local \(deviceLocal) was setup")
        }
        return local
    }
    
    static private func getStringValue(_ local: String, _ key: String, _ defaultValue: String?) -> String {
        let localId = getStringKey(local)
        var value = stringsMap[localId]?[key]?.string ?? ""
        if (value.isEmpty) {
            logStrings("\(key) was not found in remote \(localId)", true)
            value = stringsMap[STRINGS]?[key]?.string ?? ""
            if (value.isEmpty) {
                logStrings("\(key) was not found in remote \(STRINGS)", true)
                value = defaultValue ?? ""
            } else {
                logStrings("\(key) was found in remote \(STRINGS)")
            }
        }
        return value
    }
    
    static private func onResourceNotFound(_ key :String){}
    
    static private func subscriptToChanges() {}
    
    static internal func isRealTimeChangesEnabled() -> Bool {
        return _isRealTimeChangesEnabled
    }
    
    static private func getStringKey(_ id: String) -> String {
        return "\(STRINGS)_\(id)"
    }
    
    static private func getDrawableKey(_ id: String) -> String {
        return "\(DRAWABLE)_\(id)"
    }
    
    static private func log(_ log: String, _ isWarning: Bool = false) {
        if (isLogEnabled){
            if (isWarning) {
                print("\(TAG):  \(log)")
            } else {
                print("\(TAG):  \(log)")
            }
        }
    }
    
    static private func logStrings(_ log: String, _ isWarning: Bool = false) {
        if (isStringLogEnabled){
            if (isWarning) {
                print("\(TAG):  \(log)")
            } else {
                print("\(TAG):  \(log)")
            }
        }
    }
    
    static private func logDrawables(log: String, _ isWarning: Bool = false) {
        if (isDrawableLogEnabled){
            if (isWarning) {
                print("\(TAG):  \(log)")
            } else {
                print("\(TAG):  \(log)")
            }
        }
    }
}

