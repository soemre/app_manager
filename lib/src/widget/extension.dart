import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/widget/inherited.dart';
import 'package:flutter/material.dart';

extension AppSettings on BuildContext {
  AppManager get _appManager => AppManager.of(this);

  Map<String, AppManagerCore> get cores => _appManager.cores;
}
