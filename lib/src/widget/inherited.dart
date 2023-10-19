import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/base_core/types.dart';
import 'package:flutter/material.dart';

class AppManager extends InheritedWidget {
  /// The `AppManager` is an inherited widget.
  /// It stores the current cores.
  ///
  /// Use its `core` method to access the cores.
  const AppManager({
    super.key,
    required Widget child,
    required AppManagerCoreMap cores,
  })  : _cores = cores,
        super(child: child);

  /// Current Cores
  final AppManagerCoreMap _cores;

  static AppManager _of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppManager>();
    assert(result != null);
    return result!;
  }

  /// The `core` method let's you to access the current cores.
  static T core<T extends AppManagerBaseCore>(BuildContext context) =>
      AppManager._of(context)._cores[T] as T;

  @override
  bool updateShouldNotify(AppManager oldWidget) {
    return true;
  }
}
