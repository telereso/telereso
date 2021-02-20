library telereso;

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:telereso/src/constants.dart';

class Telereso {
  Telereso._privateConstructor();

  static final Telereso _instance = Telereso._privateConstructor();

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

  RemoteConfigSettings _remoteConfigSettings = null;
  Duration _remoteExpiration = null;

  init() async {
    _log("Initializing....");
    supportedLocals = [_defaultLocal];
    _remoteConfig = await _setupRemoteConfig();

    _initMaps();
    _fetchResources();
    if (_isRealTimeChangesEnalbed)
      _subscribeToChanges();
    _log("Initialized!");
  }

  Future<void> asyncInit() async {
    await init();
  }

  get remoteConfig async {
    if (_remoteConfig == null) _remoteConfig = await _setupRemoteConfig();
    return _remoteConfig;
  }

  addRemoteChangeListener(Function listener) {
    _remoteChangeListeners.add(listener);
  }

  removeRemoteChangeListener(Function listener) {
    _remoteChangeListeners.add(listener);
  }

  void _subscribeToChanges() {
    _firebaseMessaging.subscribeToTopic('TELERESO_PUSH_RC');
  }

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

  Telereso enalbeStringsLog() {
    _isStringLogEnabled = true;
    return this;
  }

  Telereso enableDrawableLog() {
    _isDrawableLogEnabled = true;
    return this;
  }

  Telereso disableLog() {
    _isLogEnabled = false;
    return this;
  }

  Telereso enalbeRealTimeChanges() {
    _isRealTimeChangesEnalbed = true;
    return this;
  }

  Telereso setRemoteConfigSettings(RemoteConfigSettings remoteConfigSettings) {
    _remoteConfigSettings = remoteConfigSettings;
    return this;
  }

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
