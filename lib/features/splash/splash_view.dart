import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/helpers/routes.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Nav.pushReplacementNamed(AppRoutes.home.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: SvgPicture.asset(AppSvg.tractianLogo, width: 180, height: 60),
        ),
      ),
    );
  }
}
