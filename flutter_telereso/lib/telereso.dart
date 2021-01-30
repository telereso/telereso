library telereso;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:telereso/src/constants.dart';

class Telereso {
  Telereso._privateConstructor();

  static final Telereso _instance = Telereso._privateConstructor();

  static Telereso get instance => _instance;

  List<String> supportedLocals = [];

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  RemoteConfig _remoteConfig;
  Set<Function> _remoteChangeListeners = Set();
  String defaultLocal = "en";

  init() async {
    print("$TAG: Initializing....");
    supportedLocals = [defaultLocal];
    _remoteConfig = await _setupRemoteConfig();

    _fetchResources();
    await _initMaps();
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

  Future<RemoteConfig> _setupRemoteConfig() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    // Allow a fetch every millisecond. Default is 12 hours.
    remoteConfig.setConfigSettings(RemoteConfigSettings());
    // remoteConfig.setDefaults(<String, String>{
    //   'strings': '',
    //   'drawable': '',
    // });
    return remoteConfig;
  }

  Future<void> _initMaps() async {
    if (_remoteConfig == null) return;
    supportedLocals = [defaultLocal];
    _remoteConfig.getAll().forEach((key, value) {
      if (key.startsWith("${STRINGS}_")) {
        supportedLocals.add(key.split("_")[1]);
      }
    });
  }

  void _fetchResources() async {
    await _remoteConfig.fetch(
        expiration: true ? Duration(seconds: 1) : Duration(hours: 12));

    if (await _remoteConfig.activateFetched()) {
      print("$TAG: Remote has changes");
      _initMaps();

      [..._remoteChangeListeners].forEach((l) {
        l();
      });
    }
  }
}
