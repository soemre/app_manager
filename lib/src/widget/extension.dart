import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/widget/inherited.dart';
import 'package:flutter/material.dart';

extension AppSettings on BuildContext {
  AppManager get _appManager => AppManager.of(this);

  AppManagerCore<T> core<T>(Enum core) =>
      _appManager.cores[core]! as AppManagerCore<T>;
}
