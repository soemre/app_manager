import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/styles/app_style_cores_enum.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

extension Styles on BuildContext {
  /// App Manager Text Style Core
  TextStyles get textStyle => style<TextStyles>(AppStyleCores.text);
}
