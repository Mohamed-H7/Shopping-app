import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/marka_controller.dart';
import '../../../models/urun_model.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/rounded_image.dart';
import '../../texts/brand_title_icon.dart';
import '../../texts/product_price_text.dart';
import '../favorite_icon/favorite_icon.dart';
import '../product_detail/product_detail.dart';
import 'widgets/Add_To_Cart_Button.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    this.image = "assets/images/product1.png",
    // this.title = "Nike Boot",
    // this.marka = "Nike",
    // this.fiyat = 35,
    // required this.urunID,
    required this.urun,
  });

  // final String image, title, marka, urunID;
  // final double fiyat;
  final String image;
  final UrunModel urun;

  bool imageFromNetwork() {
    // if (image == "assets/images/product1.png") {
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final markaController = Get.put(MarkaController());

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(
            // urunId: urun.id,
            urun: urun,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: TColors.darkGrey.withOpacity(0.1),
              blurRadius: 50,
              spreadRadius: 7,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? const Color.fromARGB(255, 66, 66, 66) : Colors.white,
        ),
        child: Column(
          children: [
            RoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  Center(
                    child: TRoundedImage(
                      imageUrl: urun.image,
                      applyImageRadius: true,
                      isNetworkImage: imageFromNetwork(),
                    ),
                  ),

                  // -- Sale Tag
                  // Positioned(
                  //   top: 12,
                  //   child: RoundedContainer(
                  //     radius: Sizes.sm,
                  //     backgroundColor: TColors.secondary.withOpacity(0.8),
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: Sizes.sm, vertical: Sizes.xs),
                  //     child: Text(
                  //       '27%',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .labelLarge!
                  //           .apply(color: Colors.black),
                  //     ),
                  //   ),
                  // ),

                  //Favorite icon
                  Positioned(
                      top: 0,
                      right: 0,
                      child: FavouriteIcon(
                        productId: urun.id,
                      )),
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),
            //
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${urun.title}                                             ',
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems / 2),
                  BrandTitleWithVerifiedIcon(
                    title: markaController.allMarka
                            .firstWhereOrNull(
                                (item) => item.id == urun.marka_id)
                            ?.ad ??
                        'null',
                  ),
                ],
              ),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.sm),
                  child: TProductPriceText(
                    price: urun.fiyat.toString(),
                  ),
                ),

                /// Container
                UrunCardAddToCartButton(
                  urun: urun,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
