# telereso_generator

Builder for [Telereso](https://pub.dev/packages/telereso) to support l10n localization

[![Pub](https://img.shields.io/pub/v/telereso_generator.svg)](https://pub.dartlang.org/packages/telereso_generator)

## Usage

1. Add `telereso_generator` to your `pubspec.yaml` as dev_dependency. Make sure [build_runner](https://pub.dev/packages/build_runner) is also listed as development dependency.
    ```yaml
     dev_dependencies:
       build_runner: ^1.0.0
       telereso_generator: ^0.0.7-alpha
    ```

2. Run flutter `pub get`.
3. Add `build.yaml` in your project's root (_next to l10n.yaml_)
    ```yaml
    targets:
      $default:
        builders:
          telereso_generator|telereso:
            enabled: true
            options:
              template-arb-file: intl_en.arb
              output-localization-file: app_localizations.dart
              output-class: AppLocalizations
              output-class-remote: RemoteLocalizations
    ```
  - Notice that first 3 options are the same as your l10n.yaml file, these flags has to be the same and required
  - `output-class-remote` is the name of your new wrapper class, if not set it will be `RemoteLocalizationsDefault`



4. Build!
    ```shell
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
   _Or watch for auto update_
    ```shell
    flutter pub run build_runner watch --delete-conflicting-outputs
    ```
5. A file will be generated with the same structure as your old localization class, you just have to use the new one in your app.   

