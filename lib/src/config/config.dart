import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/style/style.dart';

/// Config of the `AppManagerScope` widget.
///
/// To use a core or a style core, include them into the `cores` getter.
abstract class AppManagerConfig {
  /// App Manger Cores
  ///
  /// Included `cores` and `style cores` will be used by the `AppManager`.
  ///
  /// **Core:** `AppManagerCore`
  ///
  /// **Style Core:** `AppManagerStyleCore`
  List<AppManagerBaseCore>? get cores;

  /// Returns the list of AppManagerCores as an iterable.
  Iterable<AppManagerCore<Enum, dynamic>>? get coreList =>
      cores?.whereType<AppManagerCore>();

  /// Returns the list of AppManagerStyleCores as an iterable.
  Iterable<AppManagerStyleCore>? get styleCoreList =>
      cores?.whereType<AppManagerStyleCore>();
}
