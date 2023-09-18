import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppManagerThemeUtil extends AppManagerUtil with WidgetsBindingObserver {
  AppManagerThemeUtil({required super.onSystemChange});

  @override
  String get systemMode =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? "dark"
          : "light";

  @override
  Future<void> didChangePlatformBrightness() async {
    await onSystemChange();
    super.didChangePlatformBrightness();
  }
}
