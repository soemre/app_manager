import 'package:app_manager/app_manager.dart';
import 'package:app_manager_example/app_manager/cores/lang_core.dart';
import 'package:app_manager_example/app_manager/cores/theme_core.dart';
import 'package:app_manager_example/app_manager/styles/text_style.dart';

class ManagerConfig extends AppManagerConfig {
  @override
  List<AppManagerBaseCore>? get cores => [
        ThemeCore(),
        LangCore(),
        TextStyleCore(),
      ];
}
