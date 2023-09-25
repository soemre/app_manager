import 'package:app_manager/app_manager.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppManagerScope(
      cores: _cores,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

List<AppManagerCore> get _cores => [
      AppManagerCore<AppThemes, ThemeModel>(
        coreKey: AppCores.theme,
        util: AppManagerUtils.theme,
        defaultMode: AppThemes.dark,
        overrideSystem: true,
        models: {
          AppThemes.system:
              ThemeModel(backgroundColor: Colors.red, textColor: Colors.white),
          AppThemes.light:
              ThemeModel(backgroundColor: Colors.white, textColor: Colors.blue),
          AppThemes.dark: ThemeModel(
              backgroundColor: Colors.black, textColor: Colors.white),
          AppThemes.custom:
              ThemeModel(backgroundColor: Colors.blue, textColor: Colors.white),
        },
      ),
    ];

enum AppThemes {
  system,
  light,
  dark,
  custom;
}

class ThemeModel {
  final Color backgroundColor;
  final Color textColor;

  ThemeModel({
    required this.backgroundColor,
    required this.textColor,
  });
}

// Home Page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context
          .core<AppThemes, ThemeModel>(AppCores.theme)
          .current
          .backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Manager',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: context
                      .core<AppThemes, ThemeModel>(AppCores.theme)
                      .current
                      .textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(context
                          .core<AppThemes, ThemeModel>(AppCores.theme)
                          .current
                          .textColor),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      ),
                      elevation: const MaterialStatePropertyAll(0),
                      shape: const MaterialStatePropertyAll(StadiumBorder())),
                  onPressed: () => DraggableMenu.open(
                    context,
                    DraggableMenu(
                      ui: const SoftModernDraggableMenu(),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              "System",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => context
                                .core<AppThemes, ThemeModel>(AppCores.theme)
                                .changeMode(AppThemes.system),
                          ),
                          ListTile(
                            title: const Text(
                              "Light",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => context
                                .core<AppThemes, ThemeModel>(AppCores.theme)
                                .changeMode(AppThemes.light),
                          ),
                          ListTile(
                            title: const Text(
                              "Dark",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => context
                                .core<AppThemes, ThemeModel>(AppCores.theme)
                                .changeMode(AppThemes.dark),
                          ),
                          ListTile(
                            title: const Text(
                              "Custom",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () => context
                                .core<AppThemes, ThemeModel>(AppCores.theme)
                                .changeMode(AppThemes.custom),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Text(
                    "Change Mode",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context
                          .core<AppThemes, ThemeModel>(AppCores.theme)
                          .current
                          .backgroundColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Current Mode: ${context.core<AppThemes, ThemeModel>(AppCores.theme).mode.name}${context.core<AppThemes, ThemeModel>(AppCores.theme).mode == AppThemes.system ? " (Raw Mode: ${context.core<AppThemes, ThemeModel>(AppCores.theme).rawMode.name})" : ""}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context
                      .core<AppThemes, ThemeModel>(AppCores.theme)
                      .current
                      .textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AppCores {
  theme,
}
