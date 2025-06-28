import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tractian_challenge/helpers/app_widget.dart';
import 'package:tractian_challenge/helpers/injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupInjections();

  runApp(MyApp());
}
