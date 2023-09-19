import 'package:app_manager/app_manager.dart';

enum AppManagerUtils {
  theme;

  AppManagerThemeUtil create(void Function() onSystemChange) {
    switch (this) {
      case AppManagerUtils.theme:
        return AppManagerThemeUtil(onSystemChange: onSystemChange);
    }
  }
}
