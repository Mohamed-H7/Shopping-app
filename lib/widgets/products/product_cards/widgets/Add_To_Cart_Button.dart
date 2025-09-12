import 'package:alisveris/controllers/cart_controller.dart';
import 'package:alisveris/models/urun_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';

class UrunCardAddToCartButton extends StatelessWidget {
  const UrunCardAddToCartButton({
    super.key,
    required this.urun,
    // required this.urunID,
    // required this.fiyat,
  });

  // final String urunID;
  // final double fiyat;
  final UrunModel urun;

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    final cartController = CartController.instance;

    //CartController.instance

    return InkWell(
      onTap: () {
        final cartItem = cartController.convertToCartItem(urun, 1, 0);
        cartController.addOneToCart(cartItem);
      },
      child: Obx(() {
        final urunMiktarInCat =
            cartController.getProductQuantityInCart(urun.id);
        return Container(
          decoration: BoxDecoration(
            color: urunMiktarInCat > 0
                ? TColors.primary
                : ((urun.stock?[0] ?? 0) <= 0 ? Colors.grey : TColors.dark),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.cardRadiusMd),
              bottomRight: Radius.circular(Sizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: Sizes.iconLg * 1.2,
            height: Sizes.iconLg * 1.2,
            //
            child: Center(
              child: urunMiktarInCat > 0
                  ? Text(
                      urunMiktarInCat.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: Colors.white),
                    )
                  : const Icon(Iconsax.add, color: Colors.white),

              // EkleIcon(
              //   productId: urunID,
              //   fiyat: fiyat,
              // ),
            ),
          ),
        );
      }),
    );
  }
}
