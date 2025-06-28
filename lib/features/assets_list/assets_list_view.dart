import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/helpers/navigation.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class AssetsListView extends StatefulWidget {
  const AssetsListView({super.key, required this.companieId});

  final String companieId;

  @override
  State<AssetsListView> createState() => _AssetsListViewState();
}

class _AssetsListViewState extends State<AssetsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
