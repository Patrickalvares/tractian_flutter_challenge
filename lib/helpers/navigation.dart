import 'package:flutter/material.dart';

class Nav {
  static final List<String> _history = [];
  static List<String> get navigateHistory => List.unmodifiable(_history);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get currentContext => navigatorKey.currentState!.overlay!.context;

  static Future<T?> pushNamed<T extends Object?>(String route, {Object? arguments}) async {
    _history.add(route);
    return await Navigator.pushNamed<T>(currentContext, route, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?>(
    String route, {
    Object? arguments,
  }) async {
    if (_history.isNotEmpty) _history.removeLast();
    _history.add(route);
    return await Navigator.pushReplacementNamed<T, Object?>(
      currentContext,
      route,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String route, {
    Object? arguments,
  }) async {
    _history
      ..clear()
      ..add(route);
    return await Navigator.pushNamedAndRemoveUntil<T>(
      currentContext,
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future<T?> showAlert<T extends Object?>(Widget dialog) async {
    return await showDialog(context: currentContext, builder: (context) => dialog);
  }

  static void pop<T extends Object?>([T? result]) {
    Navigator.pop(currentContext, result);
  }

  static void onPopInvoke() {
    if (_history.isEmpty) return;
    _history.removeLast();
  }
}
