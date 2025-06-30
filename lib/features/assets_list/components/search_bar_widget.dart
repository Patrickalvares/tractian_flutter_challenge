import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Buscar Ativo ou Local',
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.lightFont),
        prefixIcon: const Icon(Icons.search, color: AppColor.lightFont),
        filled: true,
        fillColor: AppColor.searchBar,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Visibility(
          replacement: const SizedBox.shrink(),
          visible: controller.text.isNotEmpty,
          child: IconButton(
            onPressed: () {
              controller.clear();
              onChanged('');
            },
            icon: const Icon(Icons.clear, color: AppColor.lightFont),
          ),
        ),
      ),
    );
  }
}
