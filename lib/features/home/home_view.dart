import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';
import 'package:tractian_challenge/features/home/components/companie_button.dart';
import 'package:tractian_challenge/features/home/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends StatefulBaseState<HomeView, HomeViewmodel> {
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
        builder: (context, value, child) {
          return Column(
            children: [
              const SizedBox(height: 20),
              CompanieButton(title: 'Jaguar Unit', onTap: () {}),
              const SizedBox(height: 25),
              CompanieButton(title: 'Tobias Unit', onTap: () {}),
              const SizedBox(height: 25),
              CompanieButton(title: 'Apex Unit', onTap: () {}),
            ],
          );
        },
      ),
    );
  }
}
