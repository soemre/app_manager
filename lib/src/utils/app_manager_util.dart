abstract class AppManagerUtil {
  AppManagerUtil({
    required this.onSystemChange,
  });

  String get systemMode;

  final void Function() onSystemChange;
}
