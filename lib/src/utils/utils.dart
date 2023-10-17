import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:app_manager/src/utils/lang.dart';
import 'package:app_manager/src/utils/theme.dart';

enum AppManagerUtils {
  theme,
  lang;

  AppManagerUtil create(void Function() onSystemChange) {
    switch (this) {
      case AppManagerUtils.theme:
        return AppManagerThemeUtil(onSystemChange: onSystemChange);
      case AppManagerUtils.lang:
        return AppManagerLangUtil(onSystemChange: onSystemChange);
    }
  }
}
