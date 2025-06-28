import 'package:tractian_challenge/helpers/base_notifier.dart';
import 'package:tractian_challenge/features/home/home_state.dart';

class HomeViewmodel extends BaseNotifier<HomeState> {
  HomeViewmodel() : super(HomeInitialState());
}
