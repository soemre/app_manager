import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = "";

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.returnType.toString().replaceFirst("*", "");
  }
}
