import 'package:app_manager/app_manager.dart';
import 'package:flutter/material.dart';

extension AppSettings on BuildContext {
  AppManager get _appManager => AppManager.of(this);

  AppManagerCore<E, T> core<E extends Enum, T>(Enum core) =>
      _appManager.cores[core]! as AppManagerCore<E, T>;

  T style<T extends AppManagerStyleCore>(Enum style) =>
      _appManager.styles[style] as T;
}
