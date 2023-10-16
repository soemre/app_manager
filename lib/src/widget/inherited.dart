import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:app_manager/src/style/style.dart';
import 'package:app_manager/src/style/types.dart';
import 'package:flutter/material.dart';

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

  static T core<T extends AppManagerCore>(BuildContext context) =>
      AppManager.of(context).cores[T] as T;

  static T style<T extends AppManagerStyleCore>(BuildContext context) =>
      AppManager.of(context).styles[T] as T;

  @override
  bool updateShouldNotify(AppManager oldWidget) {
    return true;
  }
}
