import 'package:app_manager/src/utils/lang.dart';
import 'package:app_manager/src/utils/theme.dart';

abstract class AppManagerUtil {
  /// The `AppManagerUtil` class allows you to create utilities
  /// to manage the app manager cores using system features.
  AppManagerUtil() {
    init();
  }

  /// Returns the AppManagerLangUtil
  static AppManagerLangUtil get lang => AppManagerLangUtil();

  /// Returns the AppManagerThemeUtil
  static AppManagerThemeUtil get theme => AppManagerThemeUtil();

  /// Current system mode as a string.
  String get systemMode;

  /// Executed when the class initilizes.
  void init();

  /// Executed when the class disposes.
  void dispose();

  /// Binds the util with the core.
  void bindCore({
    required void Function() onSystemChange,
  }) {
    this.onSystemChange = onSystemChange;
  }

  /// Returns whether the core binded with the util by calling the bindCore or not.
  bool get isCoreBinded => onSystemChange != null;

  /// Executed when the current system mode changes.
  void Function()? onSystemChange;
}
