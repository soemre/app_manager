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
      AppManagerCore<ThemeModel>(
        name: "theme",
        util: AppManagerUtils.theme,
        models: {
          "light":
              ThemeModel(backgroundColor: Colors.white, textColor: Colors.blue),
          "dark": ThemeModel(
              backgroundColor: Colors.black, textColor: Colors.white),
          "custom":
              ThemeModel(backgroundColor: Colors.blue, textColor: Colors.white),
        },
      ),
    ];

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
      backgroundColor:
          (context.cores["theme"]!.current as ThemeModel).backgroundColor,
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
                  color:
                      (context.cores["theme"]!.current as ThemeModel).textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          (context.cores["theme"]!.current as ThemeModel)
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
                            onTap: () =>
                                context.cores["theme"]!.changeMode("system"),
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
                                context.cores["theme"]!.changeMode("light"),
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
                                context.cores["theme"]!.changeMode("dark"),
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
                                context.cores["theme"]!.changeMode("custom"),
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
                      color: (context.cores["theme"]!.current as ThemeModel)
                          .backgroundColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Current Mode: ${context.cores["theme"]!.mode}${context.cores["theme"]!.mode == "system" ? " (Raw Mode: ${context.cores["theme"]!.rawMode})" : ""}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      (context.cores["theme"]!.current as ThemeModel).textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
