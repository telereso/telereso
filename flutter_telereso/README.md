# Telereso

Flutter package to use [Telereso](telerso.io),

[Telereso](telerso.io) will allow you to control your app resources (strings,images) remotely and out of the box ,
without the need to add extra logic ,

## Installation

[Telereso](telerso.io) depends on Firebase to use [Remote Config](https://firebase.google.com/docs/remote-config/) for
resource management<br>
And [Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) for realtime changes (_optional_)

All you need to get started is make sure your project has set up
firebase ([check docs](https://firebase.google.com/docs/guides)) <br>
then just add `Telereso` dependency to your project

```yaml
dependencies:
  telereso: ^0.0.4-alpha
```

Run `pub get`.

## Usage

### Initialization

Initialization will not make api calls it's just to set up resources,

In your `main.dart` file, call `init()`:

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Telereso.instance.init();
    return MaterialApp();
  }
}
```

Skipping the Initialization will not cause crashes, but the app will not be able to use the remote version of the
resources, So it is a way to disable remote functionality.

### Firebase

Please follow the steps found [here](https://telereso.io/#firebase
) to set up your [Remote Config](https://firebase.google.com/docs/remote-config/) correctly.

### Localization

According to [Flutter Docs](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
there is 2 ways to implement localization, [Telereso](telerso.io) support both

#### Minimal internationalization

If your app implement localization
using [this approach](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#defining-a-class-for-the-apps-localized-resources),<br>
All you need to do is do the following changes :

*
Extend [BasicRemoteLocalizations](https://github.com/telereso/telereso/blob/4a0f911b4c0a77ef99f17a05a9c7164fe5ae6fe3/flutter_telereso/lib/remote_localization.dart#L11)
* Use `translateOrDefault()` to retrieve your string.

**Example**

_Before:_

```dart
class DemoLocalizations {
  DemoLocalizations(this.localeName);

  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return DemoLocalizations(localeName);
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  final String localeName;

  String get title {
    return Intl.message(
      'Hello World',
      name: 'title',
      desc: 'Title for the Demo application',
      locale: localeName,
    );
  }
}

```

_After_

```dart
class DemoLocalizations extends BasicRemoteLocalizations {
  DemoLocalizations(this.locale) : super(locale: locale);

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
}
```

#### Internationalization based on the intl package

If your app implement localization
using [this approach](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#setting-up),<br>

All you need to do is apply the following changes :

1. add [telereso_generator](https://pub.dev/packages/telereso_generator) to your `dev_dependencies`
    ```yaml
    dev_dependencies:
        build_runner: ^1.0.0
        telereso_generator: ^0.0.4-alpha
    ```
   check [telerso_generator usage](https://pub.dev/packages/telereso_generator#usage)

   Run `pub get`.

2. Add `build.yaml` in your project's root (_next to l10n.yaml_)
    ```yaml
    targets:
      $default:
        builders:
          telereso_generator|telereso:
            enabled: true
            options:
              template-arb-file: app_en.arb
              output-localization-file: app_localizations.dart
              output-class: AppLocalizations
              output-class-remote: RemoteLocalizations
    ```
  - Notice that first 3 options are the same as your l10n.yaml file, these flags has to be the same and required
  - `output-class-remote` is the name of your new wrapper class, if not set it will be `RemoteLocalizationsDefault`
3. Build
   ```shell
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
   Make sure a class named `remote_localizations.telereso.dart` was created next to your `arb` template
4. Add RemoteLocalizations delegate above your `AppLocalizations.delegate`
    ```dart
    MaterialApp(
      localizationsDelegates: [
        RemoteLocalizations.delegate //<---- add this
        AppLocalizations.delegate, //<---- keep this
      ],
      supportedLocales: [
        const Locale('nn')
      ],
      home: ...
    )
    ```
5. Start using your knew wrapper `RemoteLocalizations` instead of `AppLocalizations`

   **Example:**

   _BEFORE_
   ```dart
    // In your Material/Widget/CupertinoApp:
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appTitle,
         // ...
       );
     }
   ```
   _After_
   ```dart
    // In your Material/Widget/CupertinoApp:
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         onGenerateTitle: (BuildContext context) => RemoteLocalizations.of(context).appTitle,
         // ...
       );
     }

### Asset Images

You can make your asset images dynamic with one simple change, <br>
Use `RemoteImage.asset` instead of  `Image.asset`

**Example**
_Before_
```dart
....
child: Image.asset("assets/icons/image.png")
....
```
_After_
```dart
....
child: RemoteImage.asset("assets/icons/image.png"),
....
```

In Remote config console make sure to use full path `assets/icons/image.png` as your key in your `drawable` json, like:

```json
{
   "assets/icons/image.png": "<url>",
   "assets/icons/image2.png": "<url2>"
}
```