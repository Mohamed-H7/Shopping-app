import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../widgets/icon/circular_icon.dart';

class AddMinusBtn extends StatelessWidget {
  const AddMinusBtn({
    super.key,
    required this.miktar,
    this.add,
    this.remove,
  });

  final int miktar;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 70),

        /// Add Remove Buttons
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: Sizes.md,
              color: HelperFunctions.isDarkMode(context)
                  ? Colors.white
                  : Colors.black,
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? TColors.darkerGrey
                  : TColors.light,
              onPressed: remove,
            ),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(miktar.toString(),
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(width: Sizes.spaceBtwItems),
            CircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: Sizes.md,
              color: Colors.white,
              backgroundColor: TColors.primary,
              onPressed: add,
            ),
          ],
        ),
      ],
    );
  }
}
