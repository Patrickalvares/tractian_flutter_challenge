import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_state.dart';
import 'package:tractian_challenge/features/assets_list/assets_list_viewmodel.dart';
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
        title: Text("Assets"),
        backgroundColor: const Color.fromARGB(255, 2, 4, 26),
        toolbarHeight: 48,
      ),
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, child) {
          if (state is AssetsListLoadedState) {
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
