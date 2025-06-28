import 'package:tractian_challenge/helpers/routes.dart';
import 'package:tractian_challenge/features/home/home_view.dart';

class HomeRoute implements IRoutes {
  @override
  String get featureAppName => 'home';

  @override
  void Function() get injectionsRegister => () {};

  @override
  Map<String, WidgetBuildArgs> get routes => {AppRoutes.home.path: (_, __) => const HomeView()};
}
