import 'package:app_manager/src/utils/app_manager_util.dart';

class AppManagerUtilOptions<E extends Enum> {
  final AppManagerUtil util;
  final E system;

  AppManagerUtilOptions({
    required this.util,
    required this.system,
  });
}
