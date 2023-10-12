import 'package:app_manager/app_manager.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:app_manager/src/style/types.dart';
import 'package:flutter/material.dart';

class AppManagerScope extends StatefulWidget {
  final Widget child;
  final List<AppManagerCore>? cores;
  final List<AppManagerStyleCore>? styles;

  const AppManagerScope({
    super.key,
    required this.child,
    this.cores,
    this.styles,
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
    if (widget.cores == null) return;

    setState(() {
      for (AppManagerCore core in widget.cores!) {
        core.init();
        core.addListener(() => setState(() {}));
        _cores.addAll({core.coreKey: core});
      }
    });
  }

  void _initStyleCores() {
    if (widget.styles == null) return;

    setState(() {
      for (AppManagerStyleCore style in widget.styles!) {
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
