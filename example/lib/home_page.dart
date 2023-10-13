import 'package:app_manager_example/app_manager/app_manager.gr.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeCore.current.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Manager',
                style: context.textStyle.title,
              ),
              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        context.themeCore.current.buttonColor,
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
                              style: context.textStyle.text,
                            ),
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.system),
                          ),
                          ListTile(
                            title: Text(
                              "Light",
                              style: context.textStyle.text,
                            ),
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.light),
                          ),
                          ListTile(
                            title: Text(
                              "Dark",
                              style: context.textStyle.text,
                            ),
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.dark),
                          ),
                          ListTile(
                            title: Text(
                              "Custom",
                              style: context.textStyle.text,
                            ),
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.custom),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Text(
                    "Change Mode",
                    style: context.textStyle.buttonText,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Current Mode: ${context.themeCore.mode.name}${context.themeCore.mode == AppThemes.system ? " (Raw Mode: ${context.themeCore.rawMode.name})" : ""}",
                style: context.textStyle.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
