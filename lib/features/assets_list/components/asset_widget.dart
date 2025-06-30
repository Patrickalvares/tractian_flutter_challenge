import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/core/domain/entities/asset.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class AssetWidget extends StatelessWidget {
  const AssetWidget({
    super.key,
    required this.asset,
    required this.isSelected,
    required this.onTap,
  });

  final Asset asset;
  final bool isSelected;
  final Function(Asset) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          asset.isComponent ? AppSvg.component : AppSvg.asset,
          colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
        Text(asset.name),
      ],
    );
  }
}
