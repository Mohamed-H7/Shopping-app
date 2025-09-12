import 'package:alisveris/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../images/rounded_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    this.showAdetText = false,
    required this.cartItem,
  });

  final bool showAdetText;
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, //=> Get.to(() => ProductDetail(urun: cartItem,))
      child: Row(
        children: [
          TRoundedImage(
            isNetworkImage: true,
            imageUrl: cartItem.image ?? '',
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(Sizes.sm),
            backgroundColor: HelperFunctions.isDarkMode(context)
                ? TColors.darkGrey
                : TColors.light,
          ),
          const SizedBox(width: Sizes.spaceBtwItems),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        cartItem.markaAd ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium!.apply(),
                      ),
                    ),
                    const SizedBox(width: Sizes.xs),
                    const Icon(Iconsax.verify5,
                        color: TColors.primary, size: Sizes.iconXs),
                  ],
                ),
                Flexible(
                  child: Text(
                    cartItem.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Beden: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: '${cartItem.beden} \t\t',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (showAdetText)
                        TextSpan(
                          text: 'Adet: ',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (showAdetText)
                        TextSpan(
                          text: cartItem.miktar.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
