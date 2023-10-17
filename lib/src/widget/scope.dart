import 'package:app_manager/src/config/config.dart';
import 'package:app_manager/src/core/core.dart';
import 'package:app_manager/src/core/types.dart';
import 'package:app_manager/src/style/style.dart';
import 'package:app_manager/src/style/types.dart';
import 'package:app_manager/src/widget/inherited.dart';
import 'package:flutter/material.dart';

class AppManagerScope extends StatefulWidget {
  final Widget child;

  /// The `config` parameter takes the `AppManagerConfig`
  /// to customize its features and take the cores as well.
  final AppManagerConfig config;

  /// The `AppManagerScope` widget needs to be placed
  /// to the top of the pages it will be used on.
  /// 
  /// _Before the `MaterialApp` widget is a good place it can be at._
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

  /// Initilizes cores.
  ///
  /// Calles the init() method of the given cores.
  /// Adds them as listeners.
  /// And builds the `_cores` map with them.
  void _initCores() {
    if (widget.config.cores == null) return;

    setState(() {
      for (AppManagerCore core in widget.config.cores!) {
        core.init();
        core.addListener(() => setState(() {}));
        _cores.addAll({core.runtimeType: core});
      }
    });
  }

  /// Initilizes style cores.
  ///
  /// Calles the init() method of the given style cores
  /// and passes the current `_cores` map in order them to use it.
  /// And builds the `_styles` map with them.
  ///
  /// It doesn't listen its changes because style cores can't change their mode.
  void _initStyleCores() {
    if (widget.config.styles == null) return;

    setState(() {
      for (AppManagerStyleCore style in widget.config.styles!) {
        style.init(
          cores: _cores,
        );
        _styles.addAll({style.runtimeType: style});
      }
    });
  }

  /// Stores cores as values and their types as keys.
  final AppManagerCoreMap _cores = {};

  /// Stores style cores as values and their types as keys.
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
