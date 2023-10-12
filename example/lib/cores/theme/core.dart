import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';
import '../app_cores_enum.dart';
import 'model.dart';

class AppThemeCore extends AppManagerCore<AppThemes, ThemeModel> {
  @override
  Enum get coreKey => AppCores.theme;

  @override
  AppThemes get defaultMode => AppThemes.dark;

  @override
  Map<AppThemes, ThemeModel> get models => {
        AppThemes.system: ThemeModel(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          buttonColor: Colors.white,
          buttonTextColor: Colors.red,
        ),
        AppThemes.light: ThemeModel(
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          buttonColor: Colors.blue,
          buttonTextColor: Colors.white,
        ),
        AppThemes.dark: ThemeModel(
          backgroundColor: Colors.black,
          textColor: Colors.white,
          buttonColor: Colors.white,
          buttonTextColor: Colors.black,
        ),
        AppThemes.custom: ThemeModel(
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          buttonColor: Colors.white,
          buttonTextColor: Colors.blue,
        ),
      };

  @override
  AppManagerUtils? get util => AppManagerUtils.theme;
}

enum AppThemes {
  system,
  light,
  dark,
  custom;
}
