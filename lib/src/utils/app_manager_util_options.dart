import 'package:app_manager/src/utils/app_manager_util.dart';

class AppManagerUtilOptions<E extends Enum> {
  /// The `util` parameter takes an utility and this utility will be binded with the core.
  final AppManagerUtil util;

  /// The `system` parameter takes enum to use as the `system` mode key.
  /// This will be used to access the system's current mode
  /// and this enum shouldn't exist in the `modes` map as a key and used as default key.
  final E system;

  /// This class include parameters that a core will need when using a utiliy.
  AppManagerUtilOptions({
    required this.util,
    required this.system,
  });
}
