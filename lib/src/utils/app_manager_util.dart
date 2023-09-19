abstract class AppManagerUtil {
  AppManagerUtil({
    required this.onSystemChange,
  }) {
    init();
  }

  String get systemMode;

  void init();

  void dispose();

  final void Function() onSystemChange;
}
