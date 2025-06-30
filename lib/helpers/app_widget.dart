import 'package:flutter/material.dart';
import 'package:tractian_challenge/features/assets_list/assets_list.dart';
import 'package:tractian_challenge/features/home/home.dart';
import 'package:tractian_challenge/features/splash/splash_view.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/helpers/routes.dart';
import 'package:tractian_challenge/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, WidgetBuildArgs> routes = {};

  final List<IRoutes> microApps = [HomeRoute(), AssetsListRoute()];

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
          seedColor: AppColor.appBar,
          secondary: AppColor.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      home: const SplashView(),
      onGenerateRoute: (settings) {
        final routeBuilder = routes[settings.name];
        if (routeBuilder != null) {
          return MaterialPageRoute(
            builder: (context) => routeBuilder(context, settings.arguments),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
