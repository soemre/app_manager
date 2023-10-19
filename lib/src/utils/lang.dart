import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:flutter/material.dart';

class AppManagerLangUtil extends AppManagerUtil with WidgetsBindingObserver {
  /// You need to use correct language code.
  ///
  /// You can find out the language codes at
  /// [IANA Language Subtag Registry](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry).
  AppManagerLangUtil();

  @override
  String get systemMode =>
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (isCoreBinded) onSystemChange!();
    super.didChangeLocales(locales);
  }

  @override
  void init() {
    // Adds Widgets Binding Observer
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
