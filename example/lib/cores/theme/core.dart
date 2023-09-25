import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';
import '../app_cores_enum.dart';
import 'model.dart';

class AppThemeCore extends AppManagerCore {
  @override
  Enum get coreKey => AppCores.theme;

  @override
  Enum get defaultMode => AppThemes.dark;

  @override
  Map<Enum, dynamic> get models => {
        AppThemes.system:
            ThemeModel(backgroundColor: Colors.red, textColor: Colors.white),
        AppThemes.light:
            ThemeModel(backgroundColor: Colors.white, textColor: Colors.blue),
        AppThemes.dark:
            ThemeModel(backgroundColor: Colors.black, textColor: Colors.white),
        AppThemes.custom:
            ThemeModel(backgroundColor: Colors.blue, textColor: Colors.white),
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
