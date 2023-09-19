import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:flutter/material.dart';

import 'inherited.dart';

class AppManagerScope extends StatefulWidget {
  final Widget child;
  final List<AppManagerCore>? cores;

  const AppManagerScope({
    super.key,
    required this.child,
    this.cores,
  });

  @override
  State<AppManagerScope> createState() => _AppManagerScopeState();
}

class _AppManagerScopeState extends State<AppManagerScope> {
  @override
  void initState() {
    _initManagers();
    _initCores();
    super.initState();
  }

  void _initManagers() {
    if (widget.cores == null) return;
    for (AppManagerCore core in widget.cores!) {
      core.init();
      core.addListener(() => setState(() {}));
    }
  }

  void _initCores() {
    if (widget.cores == null) return;

    setState(() {
      for (AppManagerCore core in widget.cores!) {
        _cores.addAll({core.coreKey: core});
      }
    });
  }

  final AppManagerCoreMap _cores = {};

  @override
  Widget build(BuildContext context) {
    return AppManager(
      cores: _cores,
      child: widget.child,
    );
  }
}
