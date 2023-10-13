import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';

/// Style Cores don't have any state, therefore they are not changable.
///
/// They are just accessable via context and they reflect to the cores state.
/// So if you change a cores state, the style core will change as well
/// if it uses at least one of the cores.
abstract class AppManagerStyleCore {
  /// Key of the core.
  ///
  /// It will be used as key when accessing the styles of the app manager.
  Enum get coreKey;

  /// Stores the current cores.
  late final AppManagerCoreMap _cores;

  void init({required AppManagerCoreMap cores}) {
    _cores = cores;
  }

  AppManagerCore<E, T> core<E extends Enum, T>(Enum core) =>
      _cores[core]! as AppManagerCore<E, T>;
}
