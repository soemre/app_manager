import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/theme.dart';
import 'package:app_manager/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManagerCore<T> extends ChangeNotifier {
  AppManagerCore({
    required this.name,
    required Map<String, T> themes,
    AppManagerUtils? util,
  }) : _themes = themes {
    switch (util) {
      case AppManagerUtils.theme:
        _util = AppManagerThemeUtil(onSystemChange: _onSystemChange);
        break;
      default:
    }
  }

  final String name;

  AppManagerUtil? _util;

  String get _defaultMode => _util != null ? "system" : "default";

  String get _prefsKey => "app_manager_core_$name";

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? newMode = prefs.getString(_prefsKey);

    if (newMode == null ||
        (newMode != "system" && !_themes.containsKey(newMode))) {
      await changeMode("system");
    } else {
      await changeMode(newMode, false);
    }

    notifyListeners();
  }

  T get current {
    if (_isSystem) {
      return _systemTheme;
    }
    if (!_themes.containsKey(_mode)) {
      changeMode(_defaultMode);
      return _defaultTheme;
    }
    return _themes[_mode]!;
  }

  String _mode = "system";

  String get mode => _mode;

  String get rawMode {
    if (_isSystem) return _systemMode;
    return _mode;
  }

  Future<void> changeMode(String mode, [bool saveChanges = true]) async {
    if (!(mode == "system" && _util != null) && !_themes.containsKey(mode)) {
      throw "The given mode doesn't have a corresponding model.";
    }

    if (saveChanges) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, mode);
    }

    _mode = mode;

    notifyListeners();
  }

  Future<void> _onSystemChange() async {
    if (mode != "system") return;

    await changeMode("system", false);
    notifyListeners();
  }

  bool get _isSystem => _mode == "system" && _util != null;

  String get _systemMode => _util!.systemMode;

  T get _systemTheme => _themes[_systemMode]!;

  T get _defaultTheme => _themes[(_defaultMode == "system" && _util != null)
      ? _systemTheme
      : _defaultMode]!;

  final Map<String, T> _themes;
}
