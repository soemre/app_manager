import 'package:app_manager/src/utils/app_manager_util.dart';
import 'package:flutter/material.dart';

class AppManagerLangUtil extends AppManagerUtil with WidgetsBindingObserver {
  AppManagerLangUtil({required super.onSystemChange});

  @override
  String get systemMode =>
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;

  @override
  void didChangeLocales(List<Locale>? locales) {
    onSystemChange();
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
