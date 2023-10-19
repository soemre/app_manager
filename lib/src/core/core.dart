import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppManagerCore<E extends Enum, T> extends ChangeNotifier {
  /// The `AppManagerCore` stores enum-model maps and uses one of them as current mode.
  ///
  /// You can change the current mode using the `changeMode` method
  /// or if an utility is provided and the current mode is set to the special `system` mode
  /// (By special it means it allows system to change its mode.), current mode can change by the system.
  ///
  /// To use the `AppManagerCore` create an class and extend the `AppManagerCore`.
  /// After that you can customize your core with overriding its getters.
  ///
  /// Always use generics when creating a core. Because it will ensure the all provided mode enums and models
  /// are the same type. And therefore, it will return the provided types as well.
  ///
  /// The `modes` getter stores the mode-model items. Every provieded key will be considered as a mode
  /// and every provided value will be considered as an model by the core.
  ///
  /// An enum named `system` must be provided when the util getter is set to an core utility.
  /// The `system` enum will be an special enum to access the system's current mode.
  ///
  /// The `defaultMode` getter will be used when the current mode is set to the `system` and
  /// the provided mode doesn't exist in the core. And the `defaultMode` getter will be used
  /// when the core couldn't find any modes used in the system before.
  ///
  /// _To learn more about using the `AppManagerCore` check out the README file._
  AppManagerCore() {
    // Binds the given util to the core.
    util?.bindCore(onSystemChange: _onSystemChange);

    // Assign Default Mode
    assert(modes.containsKey(defaultMode) && defaultMode.name != "system");
    _defaultMode = defaultMode;

    // If the util parameter is set, `system` key must exist.
    if (util != null) {
      final E? tempKey = _stringToMode("system");
      assert(tempKey != null,
          "System key must exist when the util parameter is set.");
      _systemModeEnum = tempKey!;
    }

    // Configure main mode.
    if (util == null || !useSystemAsDefault) {
      _mainMode = _defaultMode;
    } else {
      _mainMode = _systemModeEnum;
    }

    assert(_isModeUsable(_mainMode));

    // Configure the current mode. It will be redefined in the init function again.
    _mode = _mainMode;
  }

  @override
  void dispose() {
    util?.dispose();
    super.dispose();
  }

  /// System mode enum variable
  ///
  /// This variable must exist
  /// to get the system variable without searching it.
  late final E _systemModeEnum;

  /// The provided mode will be used when the system mode isn't usable
  /// and the main mode will be the default mode if the `useSystemAsDefault` is set to `false`
  /// or any utility isn't provided to the core.
  late final E _defaultMode;

  /// Do not assign `system` enum.
  E get defaultMode;

  /// Whether the `system` will be overriden or not.
  ///
  /// It will be functional if an utility provided to the `core`.
  bool get useSystemAsDefault => true;

  /// The util of the core.
  ///
  /// Util is optional. But if it is set, the `system` keyword should be used as a key of the modes map.
  AppManagerUtil? util;

  /// Main mode will be used by the app manager
  /// when the current mode is not usable.
  late final E _mainMode;

  /// The key to be store the app's current mode in the local storage with Shared Preferences.
  String get _prefsKey => "app_manager_core_$runtimeType";

  /// Initialize the core's mode with the stored preferences.
  ///
  /// It will throw if the default mode isn't set in the modes map.
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

    // If the current key doesn't exist in the modes map.
    // Change the current mode to default mode.
    if (!_isModeUsable(_mode)) {
      // The default mode must be exist in the modes map as a key.
      assert(modes.containsKey(_mainMode));

      changeMode(_mainMode);
      return _mainModel;
    }

    // If the current key exists in the model map, return it.
    return modes[_mode]!;
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
  /// Throws if the given mode doesn't exists in the modes map.
  Future<void> changeMode(E mode, [bool saveChanges = true]) async {
    if (!modes.containsKey(mode)) {
      throw "The given mode doesn't exists in the modes map.";
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

  /// Returns whether the given mode indicates the special `system` mode or not.
  bool _isSystem(E mode) {
    return util != null && mode == _systemModeEnum;
  }

  /// Returns raw system keys.
  ///
  /// In order to use the util, the raw system keys must be exists in the modes map.
  E get _systemMode {
    final mode = _stringToMode(util!.systemMode);

    if (!_isModeUsable(mode)) {
      return _defaultMode;
    }

    return mode!;
  }

  /// Returns the system model from the modes map.
  ///
  /// The models with the raw system keys must be exists in the modes map.
  T get _systemModel => modes[_systemMode]!;

  /// Returns the default model of the current core.
  ///
  /// If the core has an util, it will return system model.
  ///
  /// If the core doesn't have an util, it will return the model set as the default mode.
  T get _mainModel =>
      _mainMode == _systemModeEnum ? _systemModel : modes[_mainMode]!;

  E? _stringToMode(String? string) {
    if (string == null) return null;
    try {
      return modes.keys.firstWhere((m) => m.name == string);
    } catch (_) {
      return null;
    }
  }

  /// Returns whether the given mode exists in the modes map or not.
  bool _isModeUsable(E? mode) => mode != null && modes.containsKey(mode);

  /// Modes map
  ///
  /// Stores the modes
  ///
  /// To use it create an model class and an enum.
  /// Set the enums as keys and the model instances as values of the map.
  ///
  /// The enum you created will be represent the modes of the core.
  ///
  /// **About the enum named `system`:** If an utility is provided to the core,
  /// the enum named `system` will be used as an special key to access the system's current mode.
  ///
  /// Using all the enums as keys is recommended to avoid using a not existing mode.
  Map<E, T> get modes;
}
