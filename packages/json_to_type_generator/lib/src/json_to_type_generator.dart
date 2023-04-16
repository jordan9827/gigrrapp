
import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:json_to_type/json_to_type.dart';
import 'package:source_gen/source_gen.dart';

class JsonToTypeGenerator extends GeneratorForAnnotation<JsonToType> {
  String className = '';

  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    className = visitor.className;

    final output = "$className: (data) => $className.fromJson(data),";

    return output;
  }
}

class ModelVisitor extends SimpleElementVisitor<void> {
  var className = '';

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType.toString();
  }
}
