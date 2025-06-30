import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/core/domain/entities/location.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.location,
    required this.isSelected,
    required this.onTap,
  });

  final Location location;
  final bool isSelected;
  final Function(Location) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppSvg.localization,
          colorFilter: ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
        Text(location.name),
      ],
    );
  }
}
