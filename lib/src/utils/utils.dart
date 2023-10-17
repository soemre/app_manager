import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/lang.dart';
import 'package:app_manager/src/utils/theme.dart';

/// Avaliable built-in utilities to use on the `AppManagerCore`.
enum AppManagerUtils {
  theme,
  lang;

  /// Creates a utility with the given `onSystemChange` function.
  AppManagerUtil create(void Function() onSystemChange) {
    switch (this) {
      case AppManagerUtils.theme:
        return AppManagerThemeUtil(onSystemChange: onSystemChange);
      case AppManagerUtils.lang:
        return AppManagerLangUtil(onSystemChange: onSystemChange);
    }
  }
}
