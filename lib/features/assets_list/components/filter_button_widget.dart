import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/utils/app_colors.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.icon,
    this.statusIcon,
    this.width = 94,
  });

  final String title;
  final String? icon;
  final bool isActive;
  final VoidCallback onTap;
  final String? statusIcon;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColor.primary : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColor.primary : AppColor.lightFont.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : AppColor.lightFont,
                  BlendMode.srcIn,
                ),
              ),
            ] else if (statusIcon != null) ...[
              SvgPicture.asset(
                statusIcon!,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Colors.red,
                  BlendMode.srcIn,
                ),
              ),
            ],
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : AppColor.lightFont,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
