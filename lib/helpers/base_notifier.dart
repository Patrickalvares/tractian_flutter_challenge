import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class StatefulBaseState<T extends StatefulWidget, C extends BaseNotifier>
    extends State<T> {
  final C viewModel = serviceLocator<C>();
}

final serviceLocator = GetIt.instance;

class BaseNotifier<T> extends ValueNotifier<T> {
  BaseNotifier(super.value);

  T get currentState => super.value;

  void emit(T value) {
    if (hasListeners) {
      super.value = value;
    }
  }

  void update() {
    if (hasListeners) {
      notifyListeners();
    }
  }
}
