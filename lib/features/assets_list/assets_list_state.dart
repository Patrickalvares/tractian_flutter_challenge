import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_node.dart';

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
  final List<TreeNode> treeNodes;
  final String searchText;
  final bool energyFilter;
  final bool criticalFilter;

  AssetsListLoadedState({
    required this.locations,
    required this.assets,
    this.treeNodes = const [],
    this.searchText = '',
    this.energyFilter = false,
    this.criticalFilter = false,
  });

  AssetsListLoadedState copyWith({
    List<Location>? locations,
    List<Asset>? assets,
    List<TreeNode>? treeNodes,
    String? searchText,
    bool? energyFilter,
    bool? criticalFilter,
  }) {
    return AssetsListLoadedState(
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
      treeNodes: treeNodes ?? this.treeNodes,
      searchText: searchText ?? this.searchText,
      energyFilter: energyFilter ?? this.energyFilter,
      criticalFilter: criticalFilter ?? this.criticalFilter,
    );
  }
}
