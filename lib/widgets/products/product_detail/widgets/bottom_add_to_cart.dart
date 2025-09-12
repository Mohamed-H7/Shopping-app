import 'package:alisveris/controllers/cart_controller.dart';
import 'package:alisveris/models/urun_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../icon/circular_icon.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart(
      {super.key, required this.bedenIndex, required this.urun});

  final RxInt bedenIndex;

  final UrunModel urun;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(urun,bedenIndex.value);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.defaultSpace,
        vertical: Sizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Sizes.cardRadiusLg),
          topRight: Radius.circular(Sizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Row
            Row(
              children: [
                CircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: controller.urunMiktariSepete.value > 0
                      ? Colors.black
                      : TColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  onPressed: () => controller.urunMiktariSepete.value < 1
                      ? null
                      : controller.urunMiktariSepete.value -= 1,
                ),
                const SizedBox(width: Sizes.spaceBtwItems),
                Text(
                  controller.urunMiktariSepete.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: Sizes.spaceBtwItems),
                CircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: Colors.black,
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  onPressed: () => controller.urunMiktariSepete.value += 1,
                ),
              ],
            ),

            // TProductPriceText(
            //   price: fiyat,
            //   isLarge: true,
            // ),

            ElevatedButton(
              onPressed: controller.urunMiktariSepete.value < 1
                  ? null
                  : () => controller.addToCart(urun, bedenIndex.value),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.shopping_bag,
                    color: controller.urunMiktariSepete.value < 0
                        ? Colors.black
                        : Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sepete Ekle',
                    style: TextStyle(
                        color: controller.urunMiktariSepete.value < 0
                            ? Colors.black
                            : Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
