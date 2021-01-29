import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const _STRINGS = "strings";
const _DRAWABLE = "drawable";

abstract class RemoteLocalizations {
  final Locale locale;
  RemoteConfig _remoteConfig;
  Map<String, Map<String, dynamic>> _stringsMap = Map();

  RemoteLocalizations(this.locale);
  
  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static RemoteLocalizations of(BuildContext context) {
    return Localizations.of<RemoteLocalizations>(context, RemoteLocalizations);
  }

  Future<bool> load() async {
    _remoteConfig = await _setupRemoteConfig();
    await _remoteConfig.fetch(
        expiration: true ? Duration(seconds: 1) : Duration(hours: 12));
    await _remoteConfig.activateFetched();

    // Load the language JSON file from the "lang" folder
    String defaultJson = _remoteConfig.getString(_STRINGS);
    if (defaultJson.isEmpty) {
      defaultJson = "{}";
    }

    _stringsMap[_STRINGS] = json.decode(defaultJson);

    var localId = _getStringsId(locale);

    String localJson = _remoteConfig.getString(localId);

    if (localJson.isEmpty) {
      localJson = "{}";
    }
    _stringsMap[localId] = json.decode(localJson);

    return true;
  }

  String getRemoteValue(String key) {
    var value = _stringsMap[_getStringsId(locale)][key];

    if (value == null || value.isEmpty) {
      //   recordException(
      //       Exception("no translation for $key in ${locale.languageCode}"));
      value = _stringsMap[_STRINGS][key];
    }
    if (value == null || value.isEmpty) {
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

    if (args == null) {
      return value;
    }
    return sprintf(value, args);
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

  String _getStringsId(Locale locale) {
    return "${_STRINGS}_${locale.languageCode}";
  }

  String _getDrawableId(Locale locale) {
    return "${_DRAWABLE}_${locale.languageCode}";
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
