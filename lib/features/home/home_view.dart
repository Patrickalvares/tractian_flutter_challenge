import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/home/components/companie_button.dart';
import 'package:tractian_challenge/features/home/home_state.dart';
import 'package:tractian_challenge/features/home/home_viewmodel.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends StatefulBaseState<HomeView, HomeViewmodel> {
  @override
  void initState() {
    super.initState();
    viewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(AppSvg.tractianLogo, width: 126, height: 17),
        backgroundColor: const Color.fromARGB(255, 2, 4, 26),
        toolbarHeight: 48,
      ),
      backgroundColor: AppColor.white,
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, child) {
          if (state is HomeLoadedState) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CompanieButton(title: state.companies[index].name, onTap: () {});
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 25);
                },
                itemCount: state.companies.length,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
