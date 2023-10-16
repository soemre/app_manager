import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:app_manager_example/app_manager/styles/text_style.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.core<ThemeCore>().current.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Manager',
                style: context.style<TextStyleCore>().title,
              ),
              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        context.core<ThemeCore>().current.buttonColor,
                      ),
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
                            title: Text(
                              "System",
                              style: context.style<TextStyleCore>().menuText,
                            ),
                            onTap: () => context
                                .core<ThemeCore>()
                                .changeMode(AppThemes.system),
                          ),
                          ListTile(
                            title: Text(
                              "Light",
                              style: context.style<TextStyleCore>().menuText,
                            ),
                            onTap: () => context
                                .core<ThemeCore>()
                                .changeMode(AppThemes.light),
                          ),
                          ListTile(
                            title: Text(
                              "Dark",
                              style: context.style<TextStyleCore>().menuText,
                            ),
                            onTap: () => context
                                .core<ThemeCore>()
                                .changeMode(AppThemes.dark),
                          ),
                          ListTile(
                            title: Text(
                              "Custom",
                              style: context.style<TextStyleCore>().menuText,
                            ),
                            onTap: () => context
                                .core<ThemeCore>()
                                .changeMode(AppThemes.custom),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Text(
                    "Change Mode",
                    style: context.style<TextStyleCore>().buttonText,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Current Mode: ${context.core<ThemeCore>().mode.name}${context.core<ThemeCore>().mode == AppThemes.system ? " (Raw Mode: ${context.core<ThemeCore>().rawMode.name})" : ""}",
                style: context.style<TextStyleCore>().text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
