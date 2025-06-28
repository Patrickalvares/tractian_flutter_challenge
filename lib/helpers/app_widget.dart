import 'package:flutter/material.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/helpers/routes.dart';
import 'package:tractian_challenge/features/home/home.dart';
import 'package:tractian_challenge/features/splash/splash_view.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, WidgetBuildArgs> routes = {};

  final List<IRoutes> microApps = [HomeRoute()];

  void registerRouters() {
    for (final microApp in microApps) {
      routes.addAll(microApp.routes);
    }
  }

  @override
  Widget build(BuildContext context) {
    registerRouters();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractian Challenge',
      navigatorKey: Nav.navigatorKey,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E8E3E),
          secondary: const Color(0xFFFFD700),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E8E3E),
          secondary: const Color(0xFFFFD700),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      home: const SplashView(),
      routes: routes.map((key, value) => MapEntry(key, (context) => value(context, null))),
    );
  }
}
