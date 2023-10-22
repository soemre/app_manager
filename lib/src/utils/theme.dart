import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// The `AppManagerThemeUtil` is a theme utility and it binds the theme of the device with the core.
///
/// To be able to use is your mode enums must have these names as their names:
/// - light
/// - dark
class AppManagerThemeUtil extends AppManagerUtil with WidgetsBindingObserver {
  AppManagerThemeUtil();

  @override
  String get systemMode =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? "dark"
          : "light";

  @override
  void didChangePlatformBrightness() {
    if (isCoreBound) onSystemChange!();
    super.didChangePlatformBrightness();
  }

  @override
  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
