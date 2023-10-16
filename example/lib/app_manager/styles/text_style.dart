import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:flutter/material.dart';

class TextStyleCore extends AppManagerStyleCore {
  ThemeModel get theme => core<ThemeCore>().current;

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

  TextStyle get menuText => TextStyle(
        color: theme.menuTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get buttonText => TextStyle(
        color: theme.buttonTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
}
