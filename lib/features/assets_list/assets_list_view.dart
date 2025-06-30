import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_viewmodel.dart';
import 'package:tractian_challenge/features/assets_list/components/search_filters_widget.dart';
import 'package:tractian_challenge/features/assets_list/components/tree_widget.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class AssetsListView extends StatefulWidget {
  const AssetsListView({super.key, required this.companieId});

  final String companieId;

  @override
  State<AssetsListView> createState() => _AssetsListViewState();
}

class _AssetsListViewState extends StatefulBaseState<AssetsListView, AssetsListViewmodel> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initialize(companieId: widget.companieId);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Nav.pop(),
          icon: SvgPicture.asset(AppSvg.backButtonAppbar),
        ),
        centerTitle: true,
        title: const Text("Assets", style: TextStyle(color: AppColor.white)),
        backgroundColor: AppColor.appBar,
        toolbarHeight: 48,
      ),
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, child) {
          if (state is AssetsListLoadingState) {
            return const Center(child: CircularProgressIndicator(color: AppColor.primary));
          }
          if (state is AssetsListErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Erro: ${state.errorMessage}', style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.initialize(companieId: widget.companieId),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }
          if (state is AssetsListLoadedState) {
            return Column(
              children: [
                SearchFiltersWidget(
                  searchController: _searchController,
                  onSearchChanged: viewModel.updateSearchText,
                  searchText: state.searchText,
                  energyFilter: state.energyFilter,
                  criticalFilter: state.criticalFilter,
                  onEnergyFilterToggle: viewModel.toggleEnergyFilter,
                  onCriticalFilterToggle: viewModel.toggleCriticalFilter,
                  hasActiveFilters: viewModel.hasActiveFilters,
                  onClearFilters: viewModel.clearFilters,
                ),
                Divider(color: AppColor.lightFont.withValues(alpha: 0.15), height: 1),
                Expanded(
                  child: Visibility(
                    visible: state.treeNodes.isNotEmpty,
                    replacement: const Center(
                      child: Text(
                        'Nenhum resultado encontrado',
                        style: TextStyle(fontSize: 16, color: AppColor.lightFont),
                      ),
                    ),
                    child: TreeWidget(nodes: state.treeNodes),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
