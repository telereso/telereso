library telereso;

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:telereso/src/constants.dart';

/// Singleton implantation to access Telerso functionality
class Telereso {
  Telereso._privateConstructor();

  static final Telereso _instance = Telereso._privateConstructor();

  /// return a static reference telereso library
  static Telereso get instance => _instance;

  List<String> supportedLocals = [];
  Map<String, Map<String, dynamic>> _drawableMap = {DRAWABLE: {}};

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  RemoteConfig _remoteConfig;
  Set<Function> _remoteChangeListeners = Set();
  String _defaultLocal = "en";

  bool _isLogEnabled = true;
  bool _isStringLogEnabled = false;

  get isStringLogEnabled {
    return _isStringLogEnabled;
  }

  bool _isDrawableLogEnabled = false;
  bool _isRealTimeChangesEnalbed = false;

  RemoteConfigSettings _remoteConfigSettings;

  Duration _remoteExpiration;

  /// Initialize Telereso library in async way ,
  /// It will not make any api calls and will not block the app loading ,
  /// Use it if you don't have a splash screen or the stings and images you want to control are not in the first UI
  /// Example with full options:
  ///
  /// ```dart
  ///     Telereso.instance
  ///         .disableLog() // disable general and main logs
  ///         .enableDrawableLog() // allow drawable logs so you can debug your keys and fetched values
  ///         .enableStringsLog() // allow strings logs so you can debug your locals , keys and fetched values
  ///         .setRemoteConfigSettings(RemoteConfigSettings()) // if you have custom Remote Config settings pass them here
  ///         .setRemoteExpiration(const Duration(seconds: 1)) // provide your custom duration , by default expiration will be 12 hours, if realtime changes was enabled it will be 1 sec
  ///         .enableRealTimeChanges() // enable real time changes while developing
  ///         .init();
  /// ```
  init() async {
    _log("Initializing....");
    supportedLocals = [_defaultLocal];
    _remoteConfig = await _setupRemoteConfig();

    _initMaps();
    _fetchResources();
    if (_isRealTimeChangesEnalbed) _subscribeToChanges();
    _log("Initialized!");
  }

  /// Initialize Telereso library in async way and return a future ,
  /// It will not make sure the latest changes are fetched from remote ,
  /// Use it at your splash screen to setup everything before accessing the rest of the app
  /// Example with full options:
  ///
  /// ```dart
  ///     Telereso.instance
  ///         .disableLog() // disable general and main logs
  ///         .enableDrawableLog() // allow drawable logs so you can debug your keys and fetched values
  ///         .enableStringsLog() // allow strings logs so you can debug your locals , keys and fetched values
  ///         .setRemoteConfigSettings(RemoteConfigSettings()) // if you have custom Remote Config settings pass them here
  ///         .setRemoteExpiration(const Duration(seconds: 1)) // provide your custom duration , by default expiration will be 12 hours, if realtime changes was enabled it will be 1 sec
  ///         .enableRealTimeChanges() // enable real time changes while developing
  ///         .asyncInit();
  /// ```
  Future<void> asyncInit() async {
    await init();
  }

  get remoteConfig async {
    if (_remoteConfig == null) _remoteConfig = await _setupRemoteConfig();
    return _remoteConfig;
  }

  /// if you want tot rack remote changes add your listeners here , but make sure yo added it globally once , or make sure to remove it if it was a component
  addRemoteChangeListener(Function listener) {
    _remoteChangeListeners.add(listener);
  }

  removeRemoteChangeListener(Function listener) {
    _remoteChangeListeners.add(listener);
  }

  void _subscribeToChanges() {
    _firebaseMessaging.subscribeToTopic('TELERESO_PUSH_RC');
  }

  /// Filter out push notifications regarding remote updates.
  /// Returns `true` if notifications was about remote changes
  Future<bool> handleRemoteMessage(Map<String, dynamic> message) async {
    if (message != null &&
        message.isNotEmpty &&
        message.containsKey('data') &&
        message['data']['TELERESO_CONFIG_STATE'] != null) {
      _log("Remote updated!");
      if (_isRealTimeChangesEnalbed)
        _fetchResources();
      return true;
    }
    return false;
  }

  String getRemoteImage(String key) {
    _logDrawable("********************** $key **********************");

    var url = _drawableMap[DRAWABLE][key];

    _logDrawable("url:$url");
    _logDrawable("***********************************************************");
    if (url == null || url.isEmpty) {
      return null;
    }
    return url;
  }

  /// Enables strings initialization logs and stings fetch logs , it generate a lot of long logs so it is disabled by default,
  /// Use it to fetch your stings keys and debug implantation
  Telereso enableStringsLog() {
    _isStringLogEnabled = true;
    return this;
  }

  /// Enables drawable initialization logs and drawable fetch logs , it generate a lot of long logs so it is disabled by default,
  /// Use it to fetch your images keys and debug implantation
  Telereso enableDrawableLog() {
    _isDrawableLogEnabled = true;
    return this;
  }

  /// Disables general logs like if the `sdk was successfully initialized` or `Remote was updated` ,
  /// it's enabled by default and recommended to keep it enabled because logs are minimal
  Telereso disableLog() {
    _isLogEnabled = false;
    return this;
  }

  /// Enables Realtime changes as remote changes without the need to refresh/reopen the app
  Telereso enableRealTimeChanges() {
    _isRealTimeChangesEnalbed = true;
    return this;
  }

  /// Provide your own custom settings make sure to provide at initialization only
  Telereso setRemoteConfigSettings(RemoteConfigSettings remoteConfigSettings) {
    _remoteConfigSettings = remoteConfigSettings;
    return this;
  }

  /// Provide your own remote expatiation make sure to provide at initialization only
  /// Default will be 12 hours
  Telereso setRemoteExpiration(Duration duration) {
    _remoteExpiration = duration;
    return this;
  }

  Future<RemoteConfig> _setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(
        _remoteConfigSettings ?? RemoteConfigSettings());
    return remoteConfig;
  }

  _initMaps() {
    if (_remoteConfig == null) return;
    supportedLocals = [_defaultLocal];
    _remoteConfig.getAll().forEach((key, value) {
      if (key.startsWith("${STRINGS}_")) {
        supportedLocals.add(key.split("_")[1]);
      }
    });

    String defaultDrawableJson = _remoteConfig.getString(DRAWABLE);
    if (defaultDrawableJson.isEmpty) {
      _logDrawable("Default $DRAWABLE was empty");
      defaultDrawableJson = "{}";
    } else {
      _logDrawable("Default $DRAWABLE initialized");
    }
    _drawableMap[DRAWABLE] =
        json.decode(defaultDrawableJson);
  }

  Future<void> _asyncInitMaps() {
    _initMaps();
  }

  void _fetchResources() async {
    await _remoteConfig.fetch(
        expiration: _isRealTimeChangesEnalbed
            ? Duration(seconds: 1)
            : _remoteExpiration ?? Duration(hours: 12));

    if (await _remoteConfig.activateFetched()) {
      _log("Remote has changes");
      await _asyncInitMaps();

      [..._remoteChangeListeners].forEach((l) {
        l();
      });
    }
  }
}

_log(String log) {
  if (Telereso.instance._isLogEnabled) {
    print("$TAG: $log");
  }
}

_logDrawable(String log) {
  if (Telereso.instance._isDrawableLogEnabled) {
    print("$TAG_DRAWABLE: $log");
  }
}
