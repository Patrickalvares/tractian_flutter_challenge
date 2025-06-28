import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/core/app_colors.dart';
import 'package:tractian_challenge/core/app_svg.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        highlightColor: AppColor.primary.withAlpha(25),
        splashColor: AppColor.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 76,
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: SvgPicture.asset(
                  AppSvg.location,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 21,
                  height: 18,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
