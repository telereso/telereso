import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:telereso/telereso.dart';

import 'src/constants.dart';

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
      log("$TAG_STRINGS: remoteConfig was null");
      _stringsMap[STRINGS] = {};
      _stringsMap[localId] = {};
    }

    // Load the language JSON file from the "lang" folder
    String defaultJson = _remoteConfig.getString(STRINGS);
    if (defaultJson.isEmpty) {
      log("$TAG_STRINGS: default $STRINGS was empty");
      defaultJson = "{}";
    } else {
      log("$TAG_STRINGS: default $STRINGS initialized");
    }

    _stringsMap[STRINGS] = json.decode(defaultJson);

    String localJson = _remoteConfig.getString(localId);

    if (localJson.isEmpty) {
      log("$TAG_STRINGS: local $localId was empty");
      localJson = "{}";
    } else {
      log("$TAG_STRINGS: local $localId initialized");
    }
    _stringsMap[localId] = json.decode(localJson);

    return true;
  }

  String getRemoteValue(String key) {
    final localId = _getStringsId(localeName);
    var value = _stringsMap[localId][key];

    if (value == null || value.isEmpty) {
      log("$TAG_STRINGS: $key not found in $localId");
      //   recordException(
      //       Exception("no translation for $key in ${locale.languageCode}"));
      value = _stringsMap[STRINGS][key];
    }
    if (value == null || value.isEmpty) {
      log("$TAG_STRINGS: $key not found in $STRINGS");
      // recordException(
      //     Exception("no translation for $key at defualt $defaultLocal}"));
      return null;
    }

    return value;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, [List<String> args]) {
    var value = getRemoteValue(key);

    if (value == null || value.isEmpty) {
      return null;
    }

    log("$TAG_STRINGS: key $key value: $value");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  String translateOrDefault(String key, String def, {List<String> args}) {
    var value = getRemoteValue(key);

    if (value == null || value.isEmpty) {
      value = def;
    }

    log("$TAG_STRINGS: key $key value: $value default: $def");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  String _getStringsId(String locale) {
    return "${STRINGS}_${locale}";
  }

  String _getDrawableId(String locale) {
    return "${DRAWABLE}_${locale}";
  }
}

class BasicRemoteLocalizationsDelegate
    extends LocalizationsDelegate<BasicRemoteLocalizations> {
  const BasicRemoteLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      Telereso.instance.supportedLocals.contains(locale.languageCode);

  @override
  Future<BasicRemoteLocalizations> load(Locale locale) async {
    var localizations = BasicRemoteLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(BasicRemoteLocalizationsDelegate old) => false;
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


log(String log) {
  if (Telereso.instance.stringLogEnabled) {
    print(log);
  }
}