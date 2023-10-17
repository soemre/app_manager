import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';

/// The `AppManagerCoreExtensions` extension is used to access
/// `AppManager`'s core and style methods.
extension AppManagerCoreExtensions on BuildContext {
  /// The `core` method let's you to access the current cores.
  T core<T extends AppManagerCore>() => AppManager.core<T>(this);

  /// The `style` method let's you to access the current style cores.
  T style<T extends AppManagerStyleCore>() => AppManager.style<T>(this);
}
