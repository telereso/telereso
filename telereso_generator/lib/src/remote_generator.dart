import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';

class RemoteLocalizationBuilder extends Builder {
  final BuilderOptions _options;
  String _template;
  String _localizationFile;
  String _localizationClass;
  String _newLocalizationClass;

  RemoteLocalizationBuilder(this._options) {
    this._template = _options.config["template-arb-file"];
    this._localizationFile = _options.config["output-localization-file"];
    this._localizationClass = _options.config["output-class"];
    this._newLocalizationClass = _options.config["output-class-remote"];

    validate('template-arb-file', _template);
    validate('output-localization-file', _localizationFile);
    validate('output-class', _localizationClass);
  }

  validate(String name, String attr) {
    if (attr == null)
      throw Exception(
          "$name was not found in build.yaml, please follow steps in : https://pub.dev/packages/telereso_generator#usage");

    if (attr.isEmpty)
      throw Exception(
          "$name was not found in build.yaml, please follow steps in : https://pub.dev/packages/telereso_generator#usage");
  }

  @override
  Map<String, List<String>> get buildExtensions =>
      {
        _template: [
          'remote_localization.telereso.dart'
        ]
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Retrieve the currently matched asset
    AssetId inputId = buildStep.inputId;
    var list = inputId.pathSegments;
    list.removeAt(inputId.pathSegments.length - 1);
    list.add('remote_localization.telereso.dart');

    var contents = await buildStep.readAsString(inputId);

    // Write out the new asset
    await buildStep.writeAsString(
        AssetId(inputId.package, list.join("/")),
        _generateClass(_localizationClass, _localizationFile,
            _newLocalizationClass, json.decode(contents)));
  }

  String _generateClass(String oldClassName, String oldFile, String className,
      Map<String, dynamic> json) {
    final sourceBuilder = StringBuffer();

    //imports
    sourceBuilder.writeln("import 'package:flutter/widgets.dart';");

    sourceBuilder
        .writeln("import 'package:telereso/remote_localization.dart';");

    sourceBuilder.writeln("import 'package:flutter_gen/gen_l10n/$oldFile';");

    // Class
    sourceBuilder.writeln("class $className {");

    // finals
    sourceBuilder.writeln("final BasicRemoteLocalizations remote;");
    sourceBuilder.writeln("final $oldClassName local;");

    // constructor
    sourceBuilder.writeln("$className(this.remote, this.local);");

    // Static member to have a simple access to the delegate from the MaterialApp
    sourceBuilder
        .writeln("static const delegate = BasicRemoteLocalizationsDelegate();");

    // factory from

    sourceBuilder.writeln("static $className from($oldClassName local) {");

    sourceBuilder.writeln(
        "return $className(BasicRemoteLocalizations(localeName: local.localeName), local);");

    sourceBuilder.writeln("}");

    //factory
    sourceBuilder.writeln("static $className of(BuildContext context) {");

    sourceBuilder.writeln(
        "return $className(BasicRemoteLocalizations.of(context), $oldClassName.of(context));");

    sourceBuilder.writeln("}");

    json.keys.where((key) => !key.startsWith("@")).forEach((propertyName) {
      if (json["@$propertyName"]["placeholders"] != null) {
        // getter with param

        sourceBuilder.write("String $propertyName(");
        var jsonPlaceholders =
        json["@$propertyName"]['placeholders'] as Map<String, dynamic>;
        sourceBuilder.write(jsonPlaceholders.keys
            .map((param) =>
        isNumeric(jsonPlaceholders[param]['example'])
            ? 'int $param'
            : 'Object $param')
            .join(","));

        sourceBuilder.write("){");

        var params = jsonPlaceholders.keys.join(",");
        sourceBuilder.writeln(
            "return remote?.translateOrDefault('$propertyName', local.$propertyName($params)) ?? local.$propertyName($params);");

        sourceBuilder.writeln("}");
      } else {
        // getter

        sourceBuilder.writeln("String get $propertyName =>");
        sourceBuilder.writeln(
            "remote?.translateOrDefault('$propertyName', local.$propertyName) ?? local.$propertyName;");
      }
    });

    sourceBuilder.writeln("}");

    return sourceBuilder.toString();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String _generateExtension(String oldClassName, String oldFile,
      String className, Map<String, dynamic> json) {
    final sourceBuilder = StringBuffer();

    //imports

    sourceBuilder
        .writeln("import 'package:telereso/remote_localization.dart';");

    sourceBuilder.writeln("import 'package:flutter_gen/gen_l10n/$oldFile';");

    // extension

    sourceBuilder.writeln(
        "extension $className($oldClassName default)  on RemoteLocalizations{");

    // factory of

    sourceBuilder.writeln("static $className on of(BuildContext context) {");

    sourceBuilder.writeln("return $className($oldClassName.of(context));");

    sourceBuilder.writeln("}");

    // getters

    json.keys.where((key) => !key.startsWith("@")).forEach((propertyName) {
      sourceBuilder.writeln(
          "String get $propertyName => translateOrDefault('$propertyName', $oldClassName.of(context).$propertyName);");
    });

    sourceBuilder.writeln("}");

    return sourceBuilder.toString();
  }
}
