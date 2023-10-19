import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';

/// The `AppManagerCoreExtensions` extension is used to access
/// `AppManager`'s core and style methods.
extension AppManagerCoreExtensions on BuildContext {
  /// The `core` method let's you to access the current cores.
  T core<T extends AppManagerBaseCore>() => AppManager.core<T>(this);
}
