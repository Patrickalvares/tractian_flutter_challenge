import 'package:tractian_challenge/core/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_challenge/features/home/home_state.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';

class HomeViewmodel extends BaseNotifier<HomeState> {
  HomeViewmodel({required this.getCompaniesUsecase}) : super(HomeInitialState());
  final IGetCompaniesUsecase getCompaniesUsecase;

  initialize() {
    getCompanies();
  }

  Future<void> getCompanies() async {
    emit(HomeLoadingState());
    final result = await getCompaniesUsecase.call();
    result.when(
      (failure) => emit(HomeErrorState()),
      (success) => emit(HomeLoadedState(companies: success)),
    );
  }
}
