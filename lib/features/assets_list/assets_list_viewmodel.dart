import 'package:tractian_challenge/core/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_challenge/core/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_builder.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_node.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';

class AssetsListViewmodel extends BaseNotifier<AssetsListState> {
  AssetsListViewmodel({required this.getLocationsUsecase, required this.getAssetsUsecase})
    : super(AssetsListInitialState());

  final IGetLocationsUsecase getLocationsUsecase;
  final IGetAssetsUsecase getAssetsUsecase;

  String _searchText = '';
  bool _energyFilter = false;
  bool _criticalFilter = false;

  List<TreeNode> _originalTreeNodes = [];

  Future<void> initialize({required String companieId}) async {
    await getLocations(companieId: companieId);
    final hasLocations =
        currentState is AssetsListLoadedState &&
        (currentState as AssetsListLoadedState).locations.isNotEmpty;
    if (hasLocations) await getAssets(companieId: companieId);
  }

  Future<void> getLocations({required String companieId}) async {
    final oldState = currentState;
    emit(AssetsListLoadingState());
    final result = await getLocationsUsecase.call(companieId: companieId);
    result.when((failure) => emit(AssetsListErrorState(errorMessage: failure.message)), (success) {
      emit(
        AssetsListLoadedState(
          locations: success,
          assets: oldState is AssetsListLoadedState ? oldState.assets : [],
        ),
      );
      _buildTree();
    });
  }

  Future<void> getAssets({required String companieId}) async {
    final oldState = currentState;
    emit(AssetsListLoadingState());
    final result = await getAssetsUsecase.call(companieId: companieId);
    result.when((failure) => emit(AssetsListErrorState(errorMessage: failure.message)), (success) {
      emit(
        AssetsListLoadedState(
          locations: oldState is AssetsListLoadedState ? oldState.locations : [],
          assets: success,
        ),
      );
      _buildTree();
    });
  }

  void _buildTree() {
    if (currentState is AssetsListLoadedState) {
      final state = currentState as AssetsListLoadedState;
      _originalTreeNodes = TreeBuilder.buildTreeFromData(
        locations: state.locations,
        assets: state.assets,
      );
      _applyFilters();
    }
  }

  void _applyFilters() {
    if (currentState is AssetsListLoadedState) {
      final state = currentState as AssetsListLoadedState;
      final filteredNodes = TreeBuilder.filterTree(
        nodes: _originalTreeNodes,
        searchText: _searchText,
        energyFilter: _energyFilter,
        criticalFilter: _criticalFilter,
      );

      emit(
        state.copyWith(
          treeNodes: filteredNodes,
          searchText: _searchText,
          energyFilter: _energyFilter,
          criticalFilter: _criticalFilter,
        ),
      );
    }
  }

  void updateSearchText(String searchText) {
    _searchText = searchText;
    _applyFilters();
  }

  void toggleEnergyFilter() {
    _energyFilter = !_energyFilter;
    _applyFilters();
  }

  void toggleCriticalFilter() {
    _criticalFilter = !_criticalFilter;
    _applyFilters();
  }

  void clearFilters() {
    _searchText = '';
    _energyFilter = false;
    _criticalFilter = false;
    _applyFilters();
  }

  void expandAllNodes() {
    if (currentState is AssetsListLoadedState) {
      final state = currentState as AssetsListLoadedState;
      TreeBuilder.expandAllNodes(state.treeNodes);
      emit(state.copyWith(treeNodes: [...state.treeNodes]));
    }
  }

  void collapseAllNodes() {
    if (currentState is AssetsListLoadedState) {
      final state = currentState as AssetsListLoadedState;
      TreeBuilder.collapseAllNodes(state.treeNodes);
      emit(state.copyWith(treeNodes: [...state.treeNodes]));
    }
  }

  String get searchText => _searchText;
  bool get energyFilter => _energyFilter;
  bool get criticalFilter => _criticalFilter;
  bool get hasActiveFilters => _searchText.isNotEmpty || _energyFilter || _criticalFilter;
}
