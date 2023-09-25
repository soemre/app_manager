import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppManagerCore<E extends Enum, T> extends ChangeNotifier {
  AppManagerCore() {
    // Create the util.
    _util ??= util?.create(() => _onSystemChange());

    // Assign Default Mode
    assert(models.containsKey(defaultMode) && defaultMode.name != "system");
    _defaultMode = defaultMode;

    // If the util parameter is set, `system` key must exist.
    if (_util != null) {
      final E? tempKey = _stringToMode("system");
      assert(tempKey != null,
          "System key must exist when the util parameter is set.");
      _systemModeEnum = tempKey!;
    }

    // Configure main mode.
    if (_util == null || overrideSystem) {
      _mainMode = _defaultMode;
    } else {
      _mainMode = _stringToMode("system")!;
    }

    assert(_isModeUsable(_mainMode));

    // Configure the current mode. It will be redefined in the init function again.
    _mode = _mainMode;
  }

  @override
  void dispose() {
    _util?.dispose();
    super.dispose();
  }

  late final E _systemModeEnum;

  late final E _defaultMode;

  AppManagerUtils? get util;

  E get defaultMode;

  bool get overrideSystem => false;

  /// Key of the core.
  ///
  /// It will be used as key when accessing the cores of the app manager.
  Enum get coreKey;

  /// The util of the core.
  ///
  /// Util is optional. But if it is set the `system` keyword should be used as a key of the models map.
  AppManagerUtil? _util;

  late final E _mainMode;

  /// The key to be store the app's current mode in the local storage with Shared Preferences.
  String get _prefsKey => "app_manager_core_${coreKey.name}";

  /// Initialize the core's mode with the stored preferences.
  ///
  /// It will throw if the default mode isn't set in the models map.
  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final E? localMode = _stringToMode(prefs.getString(_prefsKey));

    if (!_isModeUsable(localMode)) {
      await changeMode(_mainMode);
    } else {
      await changeMode(localMode!, false);
    }

    notifyListeners();
  }

  /// Returns the current model of the core.
  T get current {
    if (_isCurrentSystem) return _systemModel;

    // If the current key doesn't exist in the models map.
    // Change the current mode to default mode.
    if (!_isModeUsable(_mode)) {
      // The default mode must be exist in the models map as a key.
      assert(models.containsKey(_mainMode));

      changeMode(_mainMode);
      return _mainModel;
    }

    // If the current key exists in the model map, return it.
    return models[_mode]!;
  }

  // Current Mode
  late E _mode;

  /// Current mode of the core.
  E get mode => _mode;

  /// Return the underlying mode.
  ///
  /// For instance, if the mode is `system`
  /// and a util is being used
  /// it will return `dark` or `light`.
  E get rawMode {
    if (_isCurrentSystem) return _systemMode;
    return _mode;
  }

  /// Changes the mode to given mode.
  ///
  /// Throws if the given mode doesn't exists in the models map.
  Future<void> changeMode(E mode, [bool saveChanges = true]) async {
    if (!models.containsKey(mode)) {
      throw "The given mode doesn't exists in the models map.";
    }

    if (saveChanges) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, mode.name);
    }

    _mode = mode;

    notifyListeners();
  }

  /// Notify the listeners when the system's raw mode changes.
  void _onSystemChange() {
    // There is no need to notify if the current mode is system.
    if (!_isCurrentSystem) return;

    // Notify
    notifyListeners();
  }

  /// Returns whether the current core uses the system mode of an util or not.
  ///
  /// If the core doesn't use the system mode of an util, the `system` key will be a regular key.
  bool get _isCurrentSystem => _isSystem(_mode);

  bool _isSystem(E mode) {
    return _util != null && mode == _systemModeEnum;
  }

  /// Returns raw system keys.
  ///
  /// In order to use the util, the raw system keys must be exists in the models map.
  E get _systemMode {
    final mode = _stringToMode(_util!.systemMode);

    if (!_isModeUsable(mode)) {
      return _defaultMode;
    }

    return mode!;
  }

  /// Returns the system model from the models map.
  ///
  /// The models with the raw system keys must be exists in the models map.
  T get _systemModel => models[_systemMode]!;

  /// Returns the default model of the current core.
  ///
  /// If the core has an util, it will return system model.
  ///
  /// If the core doesn't have an util, it will return the model with the `default` key.
  /// That means it must be exists when the util is not set.
  T get _mainModel =>
      _mainMode == _systemModeEnum ? _systemModel : models[_mainMode]!;

  E? _stringToMode(String? string) {
    if (string == null) return null;
    try {
      return models.keys.firstWhere((m) => m.name == string);
    } catch (_) {
      return null;
    }
  }

  bool _isModeUsable(E? mode) => mode != null && models.containsKey(mode);

  /// Models Map
  ///
  /// String to Given Model Type
  Map<E, T> get models;
}
