abstract class AppManagerUtil {
  AppManagerUtil({
    required this.onSystemChange,
  });

  String get systemMode;

  final Future<void> Function() onSystemChange;
}
