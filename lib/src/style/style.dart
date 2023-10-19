import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/base_core/types.dart';

/// Style Cores don't have any modes, therefore they are not changable.
///
/// They reflect to the used cores' modes. So if you change the modes of the used cores,
/// the style core will change as well, but if it uses at least one core.
abstract class AppManagerStyleCore extends AppManagerBaseCore {
  /// Stores the current cores.
  late final AppManagerCoreMap _cores;

  /// Initilizes the style core with the given cores.
  /// This cores can be accessed inside of the style core.
  ///
  /// Cores must be the latest cores.
  void init({required AppManagerCoreMap cores}) {
    _cores = cores;
  }

  /// The `core` method let's you to access the current cores.
  T core<T extends AppManagerCore>() => _cores[T] as T;
}
