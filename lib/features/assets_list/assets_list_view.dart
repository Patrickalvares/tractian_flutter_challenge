import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_viewmodel.dart';
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
        title: const Text("Assets"),
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
                _buildSearchAndFilters(state),
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

  Widget _buildSearchAndFilters(AssetsListLoadedState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: viewModel.updateSearchText,
            decoration: InputDecoration(
              hintText: 'Buscar Ativo ou Local',
              hintStyle: const TextStyle(color: AppColor.lightFont),
              prefixIcon: const Icon(Icons.search, color: AppColor.lightFont),
              filled: true,
              fillColor: AppColor.searchBar,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              suffixIcon:
                  state.searchText.isNotEmpty
                      ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          viewModel.updateSearchText('');
                        },
                        icon: const Icon(Icons.clear, color: AppColor.lightFont),
                      )
                      : null,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildFilterButton(
                  title: 'Sensor de Energia',
                  icon: AppSvg.lightning,
                  isActive: state.energyFilter,
                  onTap: viewModel.toggleEnergyFilter,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildFilterButton(
                  title: 'Crítico',
                  icon: null,
                  isActive: state.criticalFilter,
                  onTap: viewModel.toggleCriticalFilter,
                  statusIcon: Icons.circle,
                ),
              ),
            ],
          ),
          if (viewModel.hasActiveFilters) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _searchController.clear();
                  viewModel.clearFilters();
                },
                style: TextButton.styleFrom(foregroundColor: AppColor.primary),
                child: const Text('Limpar filtros'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterButton({
    required String title,
    String? icon,
    required bool isActive,
    required VoidCallback onTap,
    IconData? statusIcon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColor.primary : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColor.primary : AppColor.lightFont.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : AppColor.lightFont,
                  BlendMode.srcIn,
                ),
              )
            else if (statusIcon != null)
              Icon(statusIcon, size: 8, color: isActive ? Colors.white : Colors.red),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : AppColor.lightFont,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
