import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';

/// Style Cores don't have any state, therefore they are not changable.
///
/// They are just accessable via context and they reflect to the cores state.
/// So if you change a cores state, the style core will change as well
/// if it uses at least one of the cores.
abstract class AppManagerStyleCore {
  /// Stores the current cores.
  late final AppManagerCoreMap _cores;

  void init({required AppManagerCoreMap cores}) {
    _cores = cores;
  }

  T core<T extends AppManagerCore>() => _cores[T] as T;
}
