import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:telereso/telereso.dart';


class RemoteLocalizationGenerator extends GeneratorForAnnotation<RemoteLocal> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateWidgetSource(element);
  }

  String _generateWidgetSource(Element element) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    visitor.visitClassElement(element);
    final sourceBuilder = StringBuffer();
    var className = visitor.className.getDisplayString(withNullability: false);
    // Class name
    sourceBuilder.writeln(
        "class ${className}Impl extends $className{");

    // Constructor
     sourceBuilder.write("${className}Impl(String locale) : super(locale);");
    //
    // final parametersBuilder = StringBuffer();
    // for (String parameterName in visitor.fields.keys) {
    //   parametersBuilder.write("this.$parameterName,");
    // }
    // sourceBuilder.write(parametersBuilder);
    // sourceBuilder.writeln(");");
    // for (String propertyName in visitor.fields.keys){
    //
    //   sourceBuilder.writeln("final ${visitor.fields[propertyName].getDisplayString(withNullability: false)} $propertyName;");
    // }

    var list = visitor.superTypes.where((e) => e != null && e.getDisplayString(withNullability: false) == "GalleryLocalizations");
    if(list.isNotEmpty){
      final superVisitor = ModelVisitor();
      list.first.element.visitChildren(superVisitor);

      for (String propertyName in superVisitor.fields.keys){
        sourceBuilder.writeln("@override");
        sourceBuilder.writeln("String get $propertyName => 'changed';");
      }
    }

    sourceBuilder.writeln("}");

    return  "/*" + sourceBuilder.toString() + "*/" ;
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType className;
  Map<String, DartType> fields = Map();
  List<InterfaceType> superTypes = [];

  @override
  visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
    return super.visitConstructorElement(element);
  }

  @override
  visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;

    return super.visitFieldElement(element);
  }

  @override
  visitClassElement(ClassElement element) {
    superTypes = element.allSupertypes;
    return super.visitClassElement(element);
  }

}
