import 'package:app_manager/app_manager.dart';

/// Config of the `AppManagerScope` widget.
///
/// To use a core or a style core include them in the `cores` and `styles` list getters.
abstract class AppManagerConfig {
  /// App Manger Cores
  ///
  /// Included `cores` will be used by the `AppManager`.
  List<AppManagerCore>? get cores;

  /// App Manger Style Cores
  ///
  /// Included `style cores` will be used by the `AppManager`.
  List<AppManagerStyleCore>? get styles;
}
