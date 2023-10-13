import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:app_manager_example/app_manager/styles/text_style.dart';
import 'package:flutter/material.dart';

extension AppManagerExtension on BuildContext {
  /// App Manager Text Style Core
  TextStyleCore get textStyle => style<TextStyleCore>();

  /// App Manager Theme Core
  ThemeCore get themeCore => core<ThemeCore>();
}
