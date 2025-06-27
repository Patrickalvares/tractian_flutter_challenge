import 'package:tractian_challenge/core/routes.dart';
import 'package:tractian_challenge/features/home/home_view.dart';

class MarketRoute implements IRoutes {
  @override
  String get featureAppName => 'home';

  @override
  void Function() get injectionsRegister => () {};

  @override
  Map<String, WidgetBuildArgs> get routes => {AppRoutes.home.path: (_, __) => const HomeView()};
}
