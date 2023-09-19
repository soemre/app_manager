import 'package:app_manager/src/core/core.dart';
import 'package:flutter/material.dart';

import 'inherited.dart';

class AppManagerScope extends StatefulWidget {
  final Widget child;
  final List? cores;

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
    super.initState();
  }

  void _initManagers() {
    if (widget.cores == null) return;
    for (AppManagerCore core in widget.cores!) {
      core.init();
      core.addListener(() => setState(() {}));
    }
  }

  Map<String, AppManagerCore> get _getCores {
    if (widget.cores == null) return {};

    final Map<String, AppManagerCore> cores = {};

    for (AppManagerCore core in widget.cores!) {
      cores.addAll({core.name: core});
    }

    return cores;
  }

  @override
  Widget build(BuildContext context) {
    return AppManager(
      cores: _getCores,
      child: widget.child,
    );
  }
}
