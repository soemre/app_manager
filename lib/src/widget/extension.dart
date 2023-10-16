import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';

extension AppSettings on BuildContext {
  AppManager get _appManager => AppManager.of(this);

  T core<T extends AppManagerCore>() => _appManager.cores[T] as T;

  T style<T extends AppManagerStyleCore>() => _appManager.styles[T] as T;
}
