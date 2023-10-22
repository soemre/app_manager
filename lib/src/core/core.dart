import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/app_manager_util_options.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppManagerCore<E extends Enum, T> extends AppManagerBaseCore
    with ChangeNotifier {
  /// The `AppManagerCore` has different modes, and its mode can change
  /// by the system with binding it with an utility, or using it's `changeMode` method.
  ///
  /// To learn how to use the `AppManagerCore` check out the README.md file.
  AppManagerCore() {
    // Assign the utility.
    utilOptions = util;

    // Bind the given utility to the core.
    _util?.bindCore(onSystemChange: _onSystemChange);

    // Assert the `system` mode key.
    assert(
      _util == null || !modes.containsKey(_systemModeKey),
      "System key mustn't exist in the modes map when the util parameter is set.",
    );

    // Assert the defaultMode.
    assert(
      modes.containsKey(defaultMode) && defaultMode != _systemModeKey,
      "Default Mode must exist in the modes map and it shouldn't be the same as the system key if an utility is provided.",
    );

    // Assign _preferedMode to the current mode. It can reassigned in the `init` method
    // if a mode is stored in the client side or the `savePreferedMode` getter is set to `true`.
    _mode = _preferedMode;
  }

  @override
  void dispose() {
    _util?.dispose();
    super.dispose();
  }

  /// System Mode Key
  E? get _systemModeKey => utilOptions?.system;

  /// The provided mode will be used when the `system` mode isn't usable
  /// and when the client side hasn't got an usable mode stored in their device
  /// but you can make it use the `system` mode instead by setting the `useSystemAsDefault` to `true`.
  E get defaultMode;

  /// The `useSystemAsDefault` getter makes the core to use the `system` mode
  /// instead of the `default` mode if the client hasn't used any modes before.
  ///
  /// It will work if an utility provided to the `core`.
  bool get useSystemAsDefault => true;

  /// The utility of the core.
  AppManagerUtil? get _util => utilOptions?.util;

  /// Always assign the utility here after taking it with the util geter
  /// because it will prevent creating mulltiple intances of it.
  late final AppManagerUtilOptions<E>? utilOptions;

  /// The `util` getter takes an `AppManagerUtilOptions` to configure the core's utility.
  ///
  /// Providing an utiliy is optional.
  ///
  /// Its `system` parameter takes enum to use as the `system` mode key.
  /// This will be used to access the system's current mode
  /// and this enum shouldn't exist in the `modes` map as a key and used as default key.
  AppManagerUtilOptions<E>? get util;

  /// SharedPreferences Key.
  String get _prefsKey => "app_manager_core_$runtimeType";

  /// If the `savePreferedMode` is set to `true` and the client hasn't got an usable mode stored,
  /// the core saves the prefered mode using the `SharedPreferences` package.
  bool get savePreferedMode => true;

  /// Save the core's mode locally and use it if a mode is saved locally.
  bool get useLocal => true;

  /// The mode to use when the client hasn't got an usable modes stored.
  E get _preferedMode =>
      (_util == null || !useSystemAsDefault) ? defaultMode : _systemModeKey!;

  /// It initializes the core.
  ///
  /// It will use the last mode if it's stored in the client side.
  Future<void> init() async {
    if (useLocal) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final E? localMode = _stringToMode(prefs.getString(_prefsKey));

      if (localMode != null) {
        // Change the current mode to the localMode
        await changeMode(localMode, false);
      } else if (savePreferedMode) {
        // Save the prefered mode
        await changeMode(_preferedMode);
      }

      notifyListeners();
    }
  }

  /// Returns the model of the current mode.
  T get current => _isCurrentModeSystem ? _systemModel : modes[_mode]!;

  /// Current Mode
  ///
  /// Do not assign a mode that doesn't exist in the `models` map.
  late E _mode;

  /// Current mode of the core.
  E get mode => _mode;

  /// It returns the raw (underlying) mode.
  ///
  /// For instance, if the current mode is `system`, it will return the mode
  /// that's being used from the `modes` map by the utility.
  E get rawMode => _isCurrentModeSystem ? _systemMode : _mode;

  /// Changes the mode to given mode.
  ///
  /// Throws if the given `mode key` doesn't exist in the `modes` map or it's not the `system` mode key.
  ///
  /// In order to the `system` mode key to work, an utility must be provided to the core.
  ///
  /// The `saveChanges` argument saves the mode locally when both the `storeUserMode` getter and the `saveChanges` argument are set to `true`.
  Future<void> changeMode(E mode, [bool saveChanges = true]) async {
    assert(
      _isModeUsable(mode),
      "The given mode doesn't exists in the modes map.",
    );

    // Save the mode using the SharedPreferences package locally.
    if (useLocal && saveChanges) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_prefsKey, mode.name);
    }

    // Change the mode.
    _mode = mode;

    notifyListeners();
  }

  /// It notifies the listeners when the system's mode changes.
  void _onSystemChange() {
    // There is no need to notify if the current mode isn't system.
    if (!_isCurrentModeSystem) return;

    notifyListeners();
  }

  /// Returns whether the current mode is the system mode or not.
  bool get _isCurrentModeSystem => _util != null && _mode == _systemModeKey;

  /// Returns raw system keys if they exist in the `modes` map.
  /// If they don't it returns the default mode instead.
  E get _systemMode => _stringToMode(_util?.systemMode) ?? defaultMode;

  /// Returns the matching `system model` from the `modes` map.
  ///
  /// The models with the raw system keys (It's what utility's looking for.) must exists in the `modes` map.
  T get _systemModel => modes[_systemMode]!;

  /// Returns the matching `mode key` if it exists in the `modes` map.
  E? _stringToMode(String? string) {
    if (string == null) return null;
    try {
      return modes.keys.firstWhere((k) => k.name == string);
    } catch (_) {
      return null;
    }
  }

  /// Returns whether the given mode is usable or not.
  bool _isModeUsable(E? mode) {
    if (mode == null) return false;
    if (mode == _systemModeKey) return true;
    return modes.containsKey(mode);
  }

  /// Stores the modes
  ///
  /// To use it, create an model class and an enum.
  /// Set the enums as keys and the model instances as values of the map.
  /// We will refer to these enums as mode keys and the key-value pairs as modes.
  ///
  /// It is recommended to use all the enums as keys to avoid attempting to use a non-existent mode.
  Map<E, T> get modes;
}
