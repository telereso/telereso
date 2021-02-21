### Minimal Initialization

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

### Full initialization options :

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
    Telereso.instance
        .disableLog() // disable general and main logs
        .enableDrawableLog() // allow drawable logs so you can debug your keys and fetched values
        .enableStringsLog() // allow strings logs so you can debug your locals , keys and fetched values
        .setRemoteConfigSettings(RemoteConfigSettings()) // if you have custom Remote Config settings pass them here
        .setRemoteExpiration(const Duration(
        seconds: 1)) // provide your custom ducation , by defualt expiration will 12 hours, if reale time changes was enabled it will be 1 sec 
        .enableRealTimeChanges() // enable real time changes while developing
        .init();
    return MaterialApp();
  }
}
```

### Localization

#### Minimal internationalization

Create demo_localizations.dart

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

in your main.dart

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
    return MaterialApp(
      title: 'Flutter App',
      localizationsDelegates: const [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: const Color(0xff6200ee),
      ),
      home: homePage(),
    );
  }
}
```

#### Internationalization based on the intl package

1. add [telereso_generator](https://pub.dev/packages/telereso_generator) to your `dev_dependencies`
    ```yaml
    dev_dependencies:
        build_runner: ^1.0.0
        telereso_generator: ^0.0.7-alpha
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


### Localization & Images & Realtime changes Example
in your main.dart

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
    return MaterialApp(
      title: 'Flutter App',
      localizationsDelegates: const [
        RemoteLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates
      ],
      theme: ThemeData(
        primaryColor: const Color(0xff6200ee),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends RemoteState<HomePage>{
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

static Future<dynamic> myBackgroundMessageHandler(
Map<String, dynamic> message) async {
// put your normal logic
if (message.containsKey('data')) {
// Handle data message
final dynamic data = message['data'];
}

if (message.containsKey('notification')) {
// Handle notification message
final dynamic notification = message['notification'];
}

// Or do other work.
}

@override
void initState() {
  super.initState();
  _firebaseMessaging.configure(
    onMessage: (message) async {
      if (await Telereso.instance.handleRemoteMessage(message)) return;
      // put your normal logic
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (message) async {},
    onResume: (message) async {},
  );
}

@override
Widget build(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        childe: Text(RemoteLocalizations.of(context).appTitle,)
      )
      Container(
        width: 80,
        height: 80,
        childe: RemoteImage.asset("assets/icons/image.png")
      ),
    ],
  );
}
}

```

