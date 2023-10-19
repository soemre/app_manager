import 'package:app_manager/src/base_core/base_core.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/style/style.dart';

/// Config of the `AppManagerScope` widget.
///
/// To use a core or a style core include them in the `cores` getter.
abstract class AppManagerConfig {
  /// App Manger Cores
  ///
  /// Included `cores` and `style cores` will be used by the `AppManager`.
  ///
  /// **Core:** `AppManagerCore`
  ///
  /// **Style Core:** `AppManagerStyleCore`
  List<AppManagerBaseCore>? get cores;

  Iterable<AppManagerCore<Enum, dynamic>>? get coreList =>
      cores?.whereType<AppManagerCore>();

  Iterable<AppManagerStyleCore>? get styleCoreList =>
      cores?.whereType<AppManagerStyleCore>();
}
