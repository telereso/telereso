/// Control your application's resources (strings ,images) remotely using firebase and out of the box by extending your current implementation.
library telereso;

import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:telereso/src/constants.dart';

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

_logStrings(String log) {
  if (Telereso.instance.isStringLogEnabled) {
    print("$TAG_STRINGS $log");
  }
}

extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}

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
      if (_isRealTimeChangesEnalbed) _fetchResources();
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
    remoteConfig
        .setConfigSettings(_remoteConfigSettings ?? RemoteConfigSettings());
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
    _drawableMap[DRAWABLE] = json.decode(defaultDrawableJson);
  }

  Future<void> _asyncInitMaps() {
    return _initMaps();
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

/// Basic implementation for Remote Localizations , extend this class in your own Localizations , or use [telereso_generator](https://pub.dev/packages/telereso_generator) and it will be used internally
class BasicRemoteLocalizations {
  RemoteConfig _remoteConfig;
  final Locale locale;
  String localeName;
  Map<String, Map<String, dynamic>> _stringsMap = Map();

  BasicRemoteLocalizations({this.localeName, this.locale}) {
    if (locale != null) {
      this.localeName = locale.languageCode;
    }
    Telereso.instance.addRemoteChangeListener(() {
      load();
    });
  }

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static BasicRemoteLocalizations of(BuildContext context) {
    return Localizations.of<BasicRemoteLocalizations>(
        context, BasicRemoteLocalizations);
  }

  Future<bool> load() async {
    _remoteConfig = await Telereso.instance.remoteConfig;

    final localId = _getStringsId(localeName);

    if (_remoteConfig == null) {
      _logStrings("RemoteConfig was null");
      _stringsMap[STRINGS] = {};
      _stringsMap[localId] = {};
    }

    // Load the language JSON file from the "lang" folder
    String defaultJson = _remoteConfig.getString(STRINGS);
    if (defaultJson.isEmpty) {
      _logStrings("$TAG_STRINGS: default $STRINGS was empty");
      defaultJson = "{}";
    } else {
      _logStrings("Default $STRINGS initialized");
    }

    _stringsMap[STRINGS] = json.decode(defaultJson);

    String localJson = _remoteConfig.getString(localId);

    if (localJson.isEmpty) {
      _logStrings("local $localId was empty");
      localJson = "{}";
    } else {
      _logStrings("local $localId initialized");
    }
    _stringsMap[localId] = json.decode(localJson);

    return true;
  }

  String getRemoteValue(String key) {
    final localId = _getStringsId(localeName);
    var value = _stringsMap[localId][key];

    if (value == null || value.isEmpty) {
      _logStrings("Not found in $localId");
      //   recordException(
      //       Exception("no translation for $key in ${locale.languageCode}"));
      value = _stringsMap[STRINGS][key];
    }
    if (value == null || value.isEmpty) {
      _logStrings("Not found in $STRINGS");
      // recordException(
      //     Exception("no translation for $key at defualt $defaultLocal}"));
      return null;
    }

    return value;
  }

  String translate(String key, [List<String> args]) {
    _logStrings("********************** $key **********************");
    var value = getRemoteValue(key);

    if (value == null || value.isEmpty) {
      return null;
    }

    _logStrings("value:$value");
    _logStrings("***********************************************************");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  /// Translate your key and if not found will fall back to default provided value
  /// args are a list of filling used with sprintf
  ///
  /// ```dart
  /// translateOrDefault("welcome_header","hi, welcome back %s",args: ["User"]))
  /// ```
  String translateOrDefault(String key, String def, {List<String> args}) {
    _logStrings("********************** $key **********************");
    var value = getRemoteValue(key);

    if (value == null || value.isEmpty) {
      value = def;
    }

    _logStrings("default:$def value:$value ");
    _logStrings("***********************************************************");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  String _getStringsId(String locale) {
    return "${STRINGS}_$locale";
  }
}

class BasicRemoteLocalizationsDelegate
    extends LocalizationsDelegate<BasicRemoteLocalizations> {
  const BasicRemoteLocalizationsDelegate();

  /// check if this LocalizationsDelegate support current local
  @override
  bool isSupported(Locale locale) =>
      Telereso.instance.supportedLocals.contains(locale.languageCode);

  /// loads locals from cached remote
  @override
  Future<BasicRemoteLocalizations> load(Locale locale) async {
    var localizations = BasicRemoteLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  /// always returns false per docs
  @override
  bool shouldReload(BasicRemoteLocalizationsDelegate old) => false;
}

/// State to be used if you like to catch realtime changes ,
/// Recommended in Development mode and on the main home page only
abstract class RemoteState<T extends StatefulWidget> extends State<T> {
  Function _remoteChangeListener = () {};

  @override
  void initState() {
    _remoteChangeListener = () {
      Future.delayed(Duration(milliseconds: 10), () {
        setState(() {});
      });
    };
    Telereso.instance.addRemoteChangeListener(_remoteChangeListener);
    super.initState();
  }

  ///Remove listeners to avoid memory leaks
  @override
  void dispose() {
    Telereso.instance.removeRemoteChangeListener(_remoteChangeListener);
    super.dispose();
  }
}

/// A wrapper to `Image.asset` , will show remote image from a url or default back to assets image
class RemoteImage {
  static Widget asset(
    String name, {
    Key key,
    AssetBundle bundle,
    ImageFrameBuilder frameBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double scale,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String package,
    FilterQuality filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  }) {
    final defautImage = Image.asset(name,
        key: key,
        bundle: bundle,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        scale: scale,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        fit: fit,
        alignment: alignment,
        repeat: repeat = ImageRepeat.noRepeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        package: package,
        filterQuality: filterQuality,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight);

    return Telereso.instance.getRemoteImage(name) != null
        ? CachedNetworkImage(
            imageUrl: Telereso.instance.getRemoteImage(name),
            placeholder: (context, url) => defautImage,
            errorWidget: (context, url, error) => defautImage,
          )
        : defautImage;
  }
}
