abstract class AssetsListState {}

class AssetsListInitialState extends AssetsListState {}

class AssetsListLoadingState extends AssetsListState {}

class AssetsListErrorState extends AssetsListState {
  AssetsListErrorState({required this.errorMessage});
  final String errorMessage;
}

class AssetsListLoadedState extends AssetsListState {}
