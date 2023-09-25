import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManagerCore<E extends Enum, T> extends ChangeNotifier {
  AppManagerCore({
    required this.coreKey,
    required Map<E, T> models,
    AppManagerUtils? util,
    E? defaultMode,
  }) : _models = models {
    // Create the util.
    _util ??= util?.create(() => _onSystemChange());

    // Configure the default mode.
    if (defaultMode == null) {
      final String defkey = _util != null ? "system" : "default";
      defaultMode = _stringToMode(defkey);
      assert(
        defaultMode != null,
        "An enum with $defkey value is not set as a key in the models map.",
      );
    } else {
      assert(
        _models.containsKey(defaultMode),
        "The $defaultMode is not set as a key in the models map.",
      );
    }

    _defaultMode = defaultMode!;

    // Configure the current mode. It will be redefined in the init function again.
    _mode = _defaultMode;
  }

  @override
  void dispose() {
    _util?.dispose();
    super.dispose();
  }

  /// Key of the core.
  ///
  /// It will be used as key when accessing the cores of the app manager.
  final Enum coreKey;

  /// The util of the core.
  ///
  /// Util is optional. But if it is set the `system` keyword should be used as a key of the models map.
  AppManagerUtil? _util;

  late final E _defaultMode;

  /// The key to be store the app's current mode in the local storage with Shared Preferences.
  String get _prefsKey => "app_manager_core_${coreKey.name}";

  /// Initialize the core's mode with the stored preferences.
  ///
  /// It will throw if the default mode isn't set in the models map.
  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final E? localMode = _stringToMode(prefs.getString(_prefsKey));

    if (!_isModeUsable(localMode)) {
      assert(_models.containsKey(_defaultMode));
      await changeMode(_defaultMode);
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
    if (!_models.containsKey(_mode)) {
      // The default mode must be exist in the models map as a key.
      assert(_models.containsKey(_defaultMode));

      changeMode(_defaultMode);
      return _defaultModel;
    }

    // If the current key exists in the model map, return it.
    return _models[_mode]!;
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
    if (!_models.containsKey(mode)) {
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
    return _util != null && mode == _defaultMode;
  }

  /// Returns raw system keys.
  ///
  /// In order to use the util, the raw system keys must be exists in the models map.
  E get _systemMode {
    final mode = _stringToMode(_util!.systemMode);

    if (_isModeUsable(mode)) {
      // TODO
      return _defaultMode;
    }

    return mode!;
  }

  /// Returns the system model from the models map.
  ///
  /// The models with the raw system keys must be exists in the models map.
  T get _systemModel => _models[_systemMode]!;

  /// Returns the default model of the current core.
  ///
  /// If the core has an util, it will return system model.
  ///
  /// If the core doesn't have an util, it will return the model with the `default` key.
  /// That means it must be exists when the util is not set.
  T get _defaultModel =>
      _isCurrentSystem ? _systemModel : _models[_defaultMode]!;

  E? _stringToMode(String? string) {
    if (string == null) return null;
    try {
      return _models.keys.firstWhere((m) => m.name == string);
    } catch (_) {
      return null;
    }
  }

  bool _isModeUsable(E? mode) => mode != null && _models.containsKey(mode);

  /// Models Map
  ///
  /// String to Given Model Type
  final Map<E, T> _models;
}
