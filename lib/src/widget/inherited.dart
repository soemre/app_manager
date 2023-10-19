import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:app_manager/src/style/style.dart';
import 'package:app_manager/src/style/types.dart';
import 'package:flutter/material.dart';

class AppManager extends InheritedWidget {
  /// The `AppManager` is an inherited widget.
  /// It stores the current cores.
  ///
  /// Use its `of` method to access its values.
  ///
  /// The values you can access are:
  /// - cores
  /// - styles
  const AppManager({
    super.key,
    required Widget child,
    required this.cores,
    required this.styles,
  }) : super(child: child);

  /// Current Cores
  final AppManagerCoreMap cores;

  /// Current Style Cores
  final AppManagerStyleCoreMap styles;

  static AppManager of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppManager>();
    assert(result != null);
    return result!;
  }

  /// The `core` method let's you to access the current cores.
  static T core<T extends AppManagerBaseCore>(BuildContext context) {
    if (_isSubtype<T, AppManagerCore>()) {
      return AppManager.of(context).cores[T] as T;
    }
    if (_isSubtype<T, AppManagerStyleCore>()) {
      return AppManager.of(context).styles[T] as T;
    }
    throw "$T isn't recognized as an app_manager core.";
  }

  static bool _isSubtype<S, T>() => <S>[] is List<T>;

  @override
  bool updateShouldNotify(AppManager oldWidget) {
    return true;
  }
}
