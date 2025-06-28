import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';

abstract class AssetsListState {}

class AssetsListInitialState extends AssetsListState {}

class AssetsListLoadingState extends AssetsListState {}

class AssetsListErrorState extends AssetsListState {
  AssetsListErrorState({required this.errorMessage});
  final String errorMessage;
}

class AssetsListLoadedState extends AssetsListState {
  final List<Location> locations;
  final List<Asset> assets;

  AssetsListLoadedState({required this.locations, required this.assets});

  AssetsListLoadedState copyWith({
    List<Location>? locations,
    List<Asset>? assets,
  }) {
    return AssetsListLoadedState(
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
    );
  }
}
