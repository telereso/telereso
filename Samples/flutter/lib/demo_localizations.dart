import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:telereso/remote_localization.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';


class DemoLocalizations extends RemoteLocalizations {
  DemoLocalizations(this.locale) : super(locale);

  @override
  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const delegate = DemoLocalizationsDelegate();

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello World',
    },
    'es': {
      'title': 'Hola Mundo',
    },
  };

  String get title {
    var key = 'title';
    return translateOrDefault(key, _localizedValues[locale.languageCode][key]);
  }

  @override
  String translate(String key, [List<String> args]) {
    return super.translate(key, args) ??
        _localizedValues[locale.languageCode][key] ??
        '';
  }

  Future<bool> shouldRefreshResources(Map<String, dynamic> message) async {
    if (message != null &&
        message.isNotEmpty &&
        message.containsKey('data') &&
        message['data']['TELERESO_CONFIG_STATE'] != null) {
      await load();
      return true;
    }

    return false;
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    var localizations = DemoLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
