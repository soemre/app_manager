import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:app_manager_example/app_manager/styles/text_style.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';
import 'package:app_manager_example/app_manager/cores/lang_core.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.core<LangCore>().current.title,
                style: context.style<TextStyleCore>().title,
              ),
              const SizedBox(height: 16),

              // Lang util example text
              Text(
                context.core<LangCore>().current.text,
                style: context.style<TextStyleCore>().text,
              ),

              const SizedBox(height: 16),

              // Status
              Text(
                "Theme: ${context.core<ThemeCore>().mode.name}${context.core<ThemeCore>().mode == AppThemes.system ? " (Raw Mode: ${context.core<ThemeCore>().rawMode.name})" : ""} \nLanguage: ${context.core<LangCore>().mode.name} ${context.core<LangCore>().mode == AppLangs.system ? " (Raw Mode: ${context.core<LangCore>().rawMode.name})" : ""} ",
                style: context.style<TextStyleCore>().text,
              ),

              const SizedBox(height: 32),

              // Lang Mode Button
              ElevatedButton(
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
                              .core<LangCore>()
                              .changeMode(AppLangs.system),
                        ),
                        ListTile(
                          title: Text(
                            "English",
                            style: context.style<TextStyleCore>().menuText,
                          ),
                          onTap: () =>
                              context.core<LangCore>().changeMode(AppLangs.eng),
                        ),
                        ListTile(
                          title: Text(
                            "Turkish",
                            style: context.style<TextStyleCore>().menuText,
                          ),
                          onTap: () =>
                              context.core<LangCore>().changeMode(AppLangs.tr),
                        ),
                        ListTile(
                          title: Text(
                            "German",
                            style: context.style<TextStyleCore>().menuText,
                          ),
                          onTap: () =>
                              context.core<LangCore>().changeMode(AppLangs.de),
                        ),
                        ListTile(
                          title: Text(
                            "Lorem Ipsum",
                            style: context.style<TextStyleCore>().menuText,
                          ),
                          onTap: () => context
                              .core<LangCore>()
                              .changeMode(AppLangs.lorem),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Text(
                  "Change Language Mode",
                  style: context.style<TextStyleCore>().buttonText,
                ),
              ),

              const SizedBox(height: 16),

              // Theme Mode Button
              ElevatedButton(
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
                  "Change Theme Mode",
                  style: context.style<TextStyleCore>().buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
