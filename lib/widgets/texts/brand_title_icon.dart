import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constans/colors.dart';
import '../../utils/constans/enums.dart';
import '../../utils/constans/sizes.dart';
import 'brand_title.dart';

class BrandTitleWithVerifiedIcon extends StatelessWidget {
  const BrandTitleWithVerifiedIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ), // TBrandTitleText
        ), // Flexible
        const SizedBox(width: Sizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: Sizes.iconXs)
      ],
    ); // Row
  }
}
