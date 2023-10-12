import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/cores/theme/core.dart';
import 'package:app_manager_example/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppManagerScope(
      cores: _cores,
      styles: _styles,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }

  /// App Cores
  List<AppManagerCore> get _cores => [
        AppThemeCore(),
      ];

  /// App Style Cores
  List<AppManagerStyleCore> get _styles => [
        TextStyles(),
      ];
}
