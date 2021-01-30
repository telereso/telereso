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
  Map<String, Map<String, dynamic>> _stringsMap = Map();

  BasicRemoteLocalizations(this.locale) {
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

    final localId = _getStringsId(locale);

    if (_remoteConfig == null) {
      print("$TAG_STRINGS: remoteConfig was null");
      _stringsMap[STRINGS] = {};
      _stringsMap[localId] = {};
    }

    // Load the language JSON file from the "lang" folder
    String defaultJson = _remoteConfig.getString(STRINGS);
    if (defaultJson.isEmpty) {
      print("$TAG_STRINGS: default $STRINGS was empty");
      defaultJson = "{}";
    } else {
      print("$TAG_STRINGS: default $STRINGS initialized");
    }

    _stringsMap[STRINGS] = json.decode(defaultJson);

    String localJson = _remoteConfig.getString(localId);

    if (localJson.isEmpty) {
      print("$TAG_STRINGS: local $localId was empty");
      localJson = "{}";
    } else {
      print("$TAG_STRINGS: local $localId initialized");
    }
    _stringsMap[localId] = json.decode(localJson);

    return true;
  }

  String getRemoteValue(String key) {
    final localId = _getStringsId(locale);
    var value = _stringsMap[localId][key];

    if (value == null || value.isEmpty) {
      print("$TAG_STRINGS: $key not found in $localId");
      //   recordException(
      //       Exception("no translation for $key in ${locale.languageCode}"));
      value = _stringsMap[STRINGS][key];
    }
    if (value == null || value.isEmpty) {
      print("$TAG_STRINGS: $key not found in $STRINGS");
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

    print("$TAG_STRINGS: key $key value: $value");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  String translateOrDefault(String key, String def, {List<String> args}) {
    var value = getRemoteValue(key);

    if (value == null || value.isEmpty) {
      print("$TAG_STRINGS: $key will be using default $def");
      value = def;
    }

    print("$TAG_STRINGS: key $key value: $value default: $def");
    if (args == null) {
      return value;
    }
    return sprintf(value, args);
  }

  String _getStringsId(Locale locale) {
    return "${STRINGS}_${locale.languageCode}";
  }

  String _getDrawableId(Locale locale) {
    return "${DRAWABLE}_${locale.languageCode}";
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
    var localizations = BasicRemoteLocalizations(locale);
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
