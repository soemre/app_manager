import 'package:app_manager/src/core/types.dart';
import 'package:flutter/material.dart';

class AppManager extends InheritedWidget {
  const AppManager({
    super.key,
    required Widget child,
    required this.cores,
  }) : super(child: child);

  final AppManagerCoreMap cores;

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
