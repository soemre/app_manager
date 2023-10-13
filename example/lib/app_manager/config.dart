import 'package:app_manager/app_manager.dart';

import 'cores/theme_core.dart';
import 'styles/text_style.dart';

class ManagerConfig extends AppManagerConfig {
  @override
  List<AppManagerCore> get cores => [
        ThemeCore(),
      ];

  @override
  List<AppManagerStyleCore> get styles => [
        TextStyleCore(),
      ];
}
