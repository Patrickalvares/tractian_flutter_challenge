import 'package:tractian_challenge/features/assets_list/assets_list_view.dart';
import 'package:tractian_challenge/helpers/routes.dart';

class AssetsListRoute implements IRoutes {
  @override
  String get featureAppName => 'assetsList';

  @override
  void Function() get injectionsRegister => () {};

  @override
  Map<String, WidgetBuildArgs> get routes => {
    AppRoutes.assetsList.path:
        (_, args) => AssetsListView(companieId: (args is String) ? args : ""),
  };
}
