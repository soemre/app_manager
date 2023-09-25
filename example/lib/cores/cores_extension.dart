import 'package:app_manager/app_manager.dart';
import 'app_cores_enum.dart';
import 'package:flutter/material.dart';
import 'theme/core.dart';
import 'theme/model.dart';

extension Cores on BuildContext {

  /// App Manager Theme Core
  AppManagerCore<AppThemes, ThemeModel> get themeCore => core<AppThemes, ThemeModel>(AppCores.theme);
}
