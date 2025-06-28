import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_svg.dart';

class CompanieButton extends StatelessWidget {
  const CompanieButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });
  final String title;
  final Function() onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        highlightColor: AppColor.primary.withAlpha(25),
        splashColor: AppColor.primary.withAlpha(50),
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Shimmer(
          enabled: isLoading,
          color: AppColor.searchBar,
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
                  child: Visibility(
                    visible: !isLoading,
                    child: SvgPicture.asset(
                      AppSvg.location,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 21,
                      height: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: isLoading ? AppColor.searchBar : AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
