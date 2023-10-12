import 'package:app_manager/src/core/types.dart';
import 'package:flutter/material.dart';
import 'package:app_manager/src/style/types.dart';

class AppManager extends InheritedWidget {
  const AppManager({
    super.key,
    required Widget child,
    required this.cores,
    required this.styles,
  }) : super(child: child);

  final AppManagerCoreMap cores;
  final AppManagerStyleCoreMap styles;

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
