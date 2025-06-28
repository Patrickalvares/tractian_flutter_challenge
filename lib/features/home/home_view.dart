import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/core/app_colors.dart';
import 'package:tractian_challenge/core/app_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    );
  }
}
