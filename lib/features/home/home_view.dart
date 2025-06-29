import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/features/home/components/companie_button.dart';
import 'package:tractian_challenge/features/home/home_state.dart';
import 'package:tractian_challenge/features/home/home_viewmodel.dart';
import 'package:tractian_challenge/helpers/base_notifier.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/helpers/routes.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initialize();
    });
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
            return RefreshIndicator(
              onRefresh: () async => viewModel.getCompanies(),
              displacement: 100,
              color: AppColor.primary,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final companie = state.companies[index];
                    return CompanieButton(
                      title: companie.name,
                      onTap: () => Nav.pushNamed(AppRoutes.assetsList.path, arguments: companie.id),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 25);
                  },
                  itemCount: state.companies.length,
                ),
              ),
            );
          }
          if (state is HomeErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      "Erro ao carregar as empresas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 60),
                    ButtonTheme(
                      child: ElevatedButton(
                        onPressed: () => viewModel.getCompanies(),
                        child: const Text("Tente novamente"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return CompanieButton(title: "", onTap: () {}, isLoading: true);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 25);
              },
              itemCount: 3,
            ),
          );
        },
      ),
    );
  }
}
