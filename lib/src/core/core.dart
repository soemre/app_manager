import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/app_manager_util_options.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppManagerCore<E extends Enum, T> extends AppManagerBaseCore
    with ChangeNotifier {
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
    // Assign the util
    utilOptions = util;

    // Binds the given util to the core.
    _util?.bindCore(onSystemChange: _onSystemChange);

    // If the util parameter is set, `system` key mustn't exist.
    assert(
      _util == null || !modes.containsKey(_systemModeEnum),
      "System key mustn't exist in the modes map when the util parameter is set.",
    );

    // Assign Default Mode
    assert(
      modes.containsKey(defaultMode) && defaultMode != _systemModeEnum,
      "Default Mode must exist in the modes map and it shouldn't be the same as the system key if an utility is provided.",
    );

    // Assign the _mainMode variable.
    if (_util == null || !useSystemAsDefault) {
      _mainMode = defaultMode;
    } else {
      _mainMode = _systemModeEnum!;
    }

    // Configure the current mode. It will be redefined in the init function again.
    _mode = _mainMode;
  }

  @override
  void dispose() {
    _util?.dispose();
    super.dispose();
  }

  /// System mode enum variable
  ///
  /// This variable must exist
  /// to get the system variable without searching it.
  E? get _systemModeEnum => utilOptions?.system;

  /// The provided mode will be used when the system mode isn't usable
  /// and the main mode will be the default mode if the `useSystemAsDefault` is set to `false`
  /// or any utility isn't provided to the core.
  E get defaultMode;

  /// Whether the `system` will be overriden or not.
  ///
  /// It will be functional if an utility provided to the `core`.
  bool get useSystemAsDefault => true;

  /// The util of the core.
  ///
  /// Util is optional. But if it is set, the `system` keyword shouldn't be used as a key of the modes map.
  AppManagerUtil? get _util => utilOptions?.util;

  /// Always assign the utility here after taking it with the util geter
  /// because it will prevent it creating intances of it.
  late final AppManagerUtilOptions<E>? utilOptions;

  /// Takes the `AppManagerUtilOptions` options to configure the core's utility.
  AppManagerUtilOptions<E>? get util;

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

    if (localMode != null) changeMode(localMode);

    notifyListeners();
  }

  /// Returns the current model of the core.
  T get current => _isCurrentModeSystem ? _systemModel : modes[_mode]!;

  /// Current Mode
  /// DO NOT ASSIGN A MODE THAT DOESN'T EXIST IN THE MODELS MAP
  late E _mode;

  /// Current mode of the core.
  E get mode => _mode;

  /// Return the underlying mode.
  ///
  /// For instance, if the mode is `system`
  /// and a util is being used
  /// it will return `dark` or `light`.
  E get rawMode => _isCurrentModeSystem ? _systemMode : _mode;

  /// Changes the mode to given mode.
  ///
  /// Throws if the given mode doesn't exists in the modes map.
  Future<void> changeMode(E mode, [bool saveChanges = true]) async {
    assert(
      _isModeUsable(mode),
      "The given mode doesn't exists in the modes map.",
    );

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
    if (!_isCurrentModeSystem) return;

    // Notify
    notifyListeners();
  }

  /// Returns whether the current core uses the system mode of an util or not.
  ///
  /// If the core doesn't use the system mode of an util, the `system` key will be a regular key.
  bool get _isCurrentModeSystem => _util != null && _mode == _systemModeEnum;

  /// Returns raw system keys.
  ///
  /// In order to use the util mode, the raw system keys must be exists in the modes map.
  E get _systemMode => _stringToMode(_util?.systemMode) ?? defaultMode;

  /// Returns the system model from the modes map.
  ///
  /// The models with the raw system keys must be exists in the modes map.
  T get _systemModel => modes[_systemMode]!;

  /// Returns the matching `mode enum` if the enum exists in the `modes` map.
  E? _stringToMode(String? string) {
    if (string == null) return null;
    try {
      return modes.keys.firstWhere((k) => k.name == string);
    } catch (_) {
      return null;
    }
  }

  /// Returns whether the given mode exists in the modes map or not.
  bool _isModeUsable(E? mode) {
    if (mode == null) return false;
    if (mode == _systemModeEnum) return true;
    return modes.containsKey(mode);
  }

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
