import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';

class ThemeCore extends AppManagerCore<AppThemes, ThemeModel> {
  @override
  AppThemes get defaultMode => AppThemes.dark;

  @override
  AppManagerUtilOptions<AppThemes>? get util => AppManagerUtilOptions(
        util: AppManagerUtil.theme,
        system: AppThemes.system,
      );

  @override
  Map<AppThemes, ThemeModel> get modes => {
        AppThemes.light: ThemeModel(
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          buttonColor: Colors.blue,
          buttonTextColor: Colors.white,
          menuTextColor: Colors.white,
        ),
        AppThemes.dark: ThemeModel(
          backgroundColor: Colors.black,
          textColor: Colors.white,
          buttonColor: Colors.white,
          buttonTextColor: Colors.black,
          menuTextColor: Colors.white,
        ),
        AppThemes.custom: ThemeModel(
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          buttonColor: Colors.white,
          buttonTextColor: Colors.blue,
          menuTextColor: Colors.white,
        ),
      };
}

enum AppThemes {
  system,
  light,
  dark,
  custom;
}

class ThemeModel {
  final Color backgroundColor;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color menuTextColor;

  ThemeModel({
    required this.menuTextColor,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
  });
}
