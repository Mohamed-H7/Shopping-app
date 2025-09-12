import 'package:alisveris/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constans/colors.dart';
import '../../utils/constans/sizes.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = false,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(Sizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor ??
                      (dark
                          ? const Color.fromARGB(255, 46, 46, 46)
                          : const Color(0xFFf5f5f5)),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: isNetworkImage
                    ? Image.network(image)
                    : Image(
                        image: AssetImage(image), //AssetImage(image)
                        fit: BoxFit.cover,
                        color: dark ? TColors.light : TColors.dark,
                      ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: dark ? Colors.white : Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
