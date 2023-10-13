import 'package:analyzer/dart/element/element.dart';
import 'package:app_manager/app_manager.dart';
import 'package:app_manager_generator/src/model_visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

class AppManagerGenerator extends GeneratorForAnnotation<ManagerCore> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final String coreKey = annotation.peek("coreKey")?.literalValue as String;

    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final String className = visitor.className;

    final buffer = StringBuffer();
    buffer.writeln("extension AppManagerExtension on BuildContext {");
    buffer.writeln("$className get ${coreKey}Core => core<$className>();");
    buffer.writeln("};");

    return buffer.toString();
  }
}
