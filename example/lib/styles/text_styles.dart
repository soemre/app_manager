import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/cores/app_cores_enum.dart';
import 'package:app_manager_example/cores/theme/core.dart';
import 'package:app_manager_example/cores/theme/model.dart';
import 'package:app_manager_example/styles/app_style_cores_enum.dart';
import 'package:flutter/material.dart';

class TextStyles extends AppManagerStyleCore {
  @override
  Enum get coreKey => AppStyleCores.text;

  ThemeModel get theme => core<AppThemes, ThemeModel>(AppCores.theme).current;

  TextStyle get title => TextStyle(
        color: theme.textColor,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      );

  TextStyle get text => TextStyle(
        color: theme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get buttonText => TextStyle(
        color: theme.buttonTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
}
