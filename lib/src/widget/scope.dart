import 'package:app_manager/src/config/config.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:app_manager/src/style/style.dart';
import 'package:app_manager/src/style/types.dart';
import 'package:app_manager/src/widget/inherited.dart';
import 'package:flutter/material.dart';

class AppManagerScope extends StatefulWidget {
  final Widget child;
  final AppManagerConfig config;

  const AppManagerScope({
    super.key,
    required this.child,
    required this.config,
  });

  @override
  State<AppManagerScope> createState() => _AppManagerScopeState();
}

class _AppManagerScopeState extends State<AppManagerScope> {
  @override
  void initState() {
    _initCores();
    _initStyleCores();
    super.initState();
  }

  void _initCores() {
    if (widget.config.cores == null) return;

    setState(() {
      for (AppManagerCore core in widget.config.cores!) {
        core.init();
        core.addListener(() => setState(() {}));
        _cores.addAll({core.coreKey: core});
      }
    });
  }

  void _initStyleCores() {
    if (widget.config.styles == null) return;

    setState(() {
      for (AppManagerStyleCore style in widget.config.styles!) {
        style.init(
          cores: _cores,
        );
        _styles.addAll({style.coreKey: style});
      }
    });
  }

  final AppManagerCoreMap _cores = {};

  final AppManagerStyleCoreMap _styles = {};

  @override
  Widget build(BuildContext context) {
    return AppManager(
      cores: _cores,
      styles: _styles,
      child: widget.child,
    );
  }
}
