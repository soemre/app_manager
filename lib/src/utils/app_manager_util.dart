abstract class AppManagerUtil {
  /// The `AppManagerUtil` class allows you to create utilities
  /// to manage the app manager cores.
  AppManagerUtil({
    required this.onSystemChange,
  }) {
    init();
  }

  /// Current system mode as a string.
  String get systemMode;

  /// Executed when the class initilizes.
  void init();

  /// Executed when the class disposes.
  void dispose();

  /// Executed when the current system mode changes.
  final void Function() onSystemChange;
}
