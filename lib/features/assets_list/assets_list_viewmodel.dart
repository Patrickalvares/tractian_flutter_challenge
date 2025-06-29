import 'package:tractian_challenge/core/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/core/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';

class AssetsListViewmodel extends BaseNotifier<AssetsListState> {
  AssetsListViewmodel({required this.getLocationsUsecase, required this.getAssetsUsecase})
    : super(AssetsListInitialState());

  final IGetLocationsUsecase getLocationsUsecase;
  final IGetAssetsUsecase getAssetsUsecase;

  Future<void> initialize({required String companieId}) async {
    await Future.wait([getLocations(companieId: companieId), getAssets(companieId: companieId)]);
  }

  Future<void> getLocations({required String companieId}) async {
    final oldState = currentState;
    emit(AssetsListLoadingState());
    final result = await getLocationsUsecase.call(companieId: companieId);
    result.when(
      (failure) => emit(AssetsListErrorState(errorMessage: failure.message)),
      (success) => emit(
        AssetsListLoadedState(
          locations: success,
          assets: oldState is AssetsListLoadedState ? oldState.assets : [],
        ),
      ),
    );
  }

  Future<void> getAssets({required String companieId}) async {
    final oldState = currentState;
    emit(AssetsListLoadingState());
    final result = await getAssetsUsecase.call(companieId: companieId);
    result.when(
      (failure) => emit(AssetsListErrorState(errorMessage: failure.message)),
      (success) => emit(
        AssetsListLoadedState(
          locations: oldState is AssetsListLoadedState ? oldState.locations : [],
          assets: success,
        ),
      ),
    );
  }
}
