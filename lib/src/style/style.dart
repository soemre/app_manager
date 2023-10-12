import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';

abstract class AppManagerStyleCore {
  AppManagerStyleCore();

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
