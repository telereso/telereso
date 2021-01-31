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
  Map<String, Map<String, dynamic>> drawableMap = {DRAWABLE: {}};

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  RemoteConfig _remoteConfig;
  Set<Function> _remoteChangeListeners = Set();
  String defaultLocal = "en";

  bool stringLogEnabled = true;
  bool drawableLogEnabled = true;

  init() async {
    print("$TAG: Initializing....");
    supportedLocals = [defaultLocal];
    _remoteConfig = await _setupRemoteConfig();

    _initMaps();
    _fetchResources();
    print("$TAG: Initialized!");
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

  void subscribeToChanges() {
    _firebaseMessaging.subscribeToTopic('TELERESO_PUSH_RC');
  }

  Future<bool> handleRemoteMessage(Map<String, dynamic> message) async {
    if (message != null &&
        message.isNotEmpty &&
        message.containsKey('data') &&
        message['data']['TELERESO_CONFIG_STATE'] != null) {
      print("$TAG: Remote updated!");
      _fetchResources();
      return true;
    }
    return false;
  }

  String getRemoteImage(String key) {
    var url = drawableMap[DRAWABLE][key];

    if (url == null || url.isEmpty) {
      return null;
    }
    return url;
  }

  Future<RemoteConfig> _setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings());
    return remoteConfig;
  }

  _initMaps() {
    if (_remoteConfig == null) return;
    supportedLocals = [defaultLocal];
    _remoteConfig.getAll().forEach((key, value) {
      if (key.startsWith("${STRINGS}_")) {
        supportedLocals.add(key.split("_")[1]);
      }
    });

    String defaultDrawableJson = _remoteConfig.getString(DRAWABLE);
    if (defaultDrawableJson.isEmpty) {
      logDrawable("$TAG_DRAWABLE: default $DRAWABLE was empty");
      defaultDrawableJson = "{}";
    } else {
      logDrawable("$TAG_DRAWABLE: default $DRAWABLE initialized");
    }
    drawableMap[DRAWABLE] =
        json.decode(defaultDrawableJson);
  }

  Future<void> _asyncInitMaps() {
    _initMaps();
  }

  void _fetchResources() async {
    await _remoteConfig.fetch(
        expiration: true ? Duration(seconds: 1) : Duration(hours: 12));

    if (await _remoteConfig.activateFetched()) {
      print("$TAG: Remote has changes");
      await _asyncInitMaps();

      [..._remoteChangeListeners].forEach((l) {
        l();
      });
    }
  }
}

logDrawable(String log) {
  if (Telereso.instance.drawableLogEnabled) {
    print(log);
  }
}
