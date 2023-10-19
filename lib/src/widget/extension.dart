import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/widget/inherited.dart';
import 'package:flutter/material.dart';

/// The `AppManagerCoreExtensions` extension is utilized to access the `core` method of `AppManager`.
extension AppManagerCoreExtensions on BuildContext {
  /// The `core` method let's you to access the current cores.
  T core<T extends AppManagerBaseCore>() => AppManager.core<T>(this);
}
