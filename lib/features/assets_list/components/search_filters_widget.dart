import 'package:flutter/material.dart';
import 'package:tractian_challenge/features/assets_list/components/filter_button_widget.dart';
import 'package:tractian_challenge/features/assets_list/components/search_bar_widget.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class SearchFiltersWidget extends StatelessWidget {
  const SearchFiltersWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.searchText,
    required this.energyFilter,
    required this.criticalFilter,
    required this.onEnergyFilterToggle,
    required this.onCriticalFilterToggle,
    required this.hasActiveFilters,
    required this.onClearFilters,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final String searchText;
  final bool energyFilter;
  final bool criticalFilter;
  final VoidCallback onEnergyFilterToggle;
  final VoidCallback onCriticalFilterToggle;
  final bool hasActiveFilters;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SearchBarWidget(controller: searchController, onChanged: onSearchChanged),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FilterButtonWidget(
                title: 'Sensor de Energia',
                icon: AppSvg.emptyLightning,
                isActive: energyFilter,
                onTap: onEnergyFilterToggle,
                width: 166,
              ),
              const SizedBox(width: 8),
              FilterButtonWidget(
                title: 'Crítico',
                isActive: criticalFilter,
                onTap: onCriticalFilterToggle,
                statusIcon: AppSvg.alert,
                width: 94,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
