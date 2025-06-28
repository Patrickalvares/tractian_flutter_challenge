import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';

class AssetsListViewmodel extends BaseNotifier<AssetsListState> {
  AssetsListViewmodel() : super(AssetsListInitialState());
}
