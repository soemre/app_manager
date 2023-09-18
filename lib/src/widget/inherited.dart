import 'package:flutter/material.dart';
import '../core/core.dart';

class AppManager extends InheritedWidget {
  const AppManager({
    super.key,
    required Widget child,
    required this.cores,
  }) : super(child: child);

  final Map<String, AppManagerCore> cores;

  static AppManager of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppManager>();
    assert(result != null);
    return result!;
  }

  @override
  bool updateShouldNotify(AppManager oldWidget) {
    return true;
  }
}
