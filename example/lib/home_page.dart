import 'package:app_manager_example/cores/cores_extension.dart';
import 'package:app_manager_example/cores/theme/core.dart';
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
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: context.themeCore.current.textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          context.themeCore.current.textColor),
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
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.system),
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
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.light),
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
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.dark),
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
                            onTap: () =>
                                context.themeCore.changeMode(AppThemes.custom),
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
                      color: context.themeCore.current.backgroundColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Current Mode: ${context.themeCore.mode.name}${context.themeCore.mode == AppThemes.system ? " (Raw Mode: ${context.themeCore.rawMode.name})" : ""}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context.themeCore.current.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
