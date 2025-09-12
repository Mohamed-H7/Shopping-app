import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/cart_controller.dart';
import '../../../controllers/marka_controller.dart';
import '../../../models/urun_model.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../chips/choice_chip.dart';
import '../../custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../texts/section_heading.dart';
import '../favorite_icon/favorite_icon.dart';
import 'widgets/bottom_add_to_cart.dart';
import 'widgets/product_meta_data.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.urun,
  });

  // final String urunId;
  // final double fiyat;
  final UrunModel urun;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    // final controller = Get.put(UrunlerController());
    // final urun = controller.tumUrunler.firstWhere(
    //   (item) => item.id == urunId,
    //   orElse: () => UrunModel.empty(),
    // );
    final markaController = Get.put(MarkaController());
    final bedenControllers = Get.put(BedenControllers());

    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        urun: urun,
        bedenIndex: bedenControllers.selectedIndex,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 - Product Image Slider
            CurvedEdgeWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 400,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Sizes.productImageRadius * 2),
                        child: Center(
                          child: (urun.image.isNotEmpty)
                              ? Image(image: NetworkImage(urun.image))
                              : Text('Error',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply()),
                        ),
                      ),
                    ),
                    SAppBar(
                      showBackArrow: true,
                      actions: [
                        FavouriteIcon(
                          productId: urun.id,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 2 - Product Details

            Padding(
              padding: const EdgeInsets.only(
                right: Sizes.defaultSpace,
                left: Sizes.defaultSpace,
                bottom: Sizes.defaultSpace,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Text((urun.title == '') ? 'Error' : urun.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.apply()),
                  const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                  /// Rating & Share Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Rating
                      Row(
                        children: [
                          const Icon(Iconsax.star5,
                              color: Colors.amber, size: 24),
                          const SizedBox(width: Sizes.spaceBtwItems / 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '5.0',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                // const TextSpan(text: ' (199)'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// - Price, Title, Stock, & Brand
                  ProductMetaData(
                    fiyat: urun.fiyat.toString(),
                    markaAd: markaController.allMarka
                            .firstWhereOrNull(
                                (item) => item.id == urun.marka_id)
                            ?.ad ??
                        'null',
                    markaImage: markaController.allMarka
                            .firstWhereOrNull(
                                (item) => item.id == urun.marka_id)
                            ?.image ??
                        'null',
                    adet: 0, //urun.stock
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                  /// - Attributes
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading(
                        title: 'Beden',
                        showActionButton: false,
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems / 2),
                      //
                      urun.beden != null
                          ? Obx(
                              () => Wrap(
                                spacing: 8,
                                children: List.generate(
                                  urun.beden!.length,
                                  (index) => TChoiceChip(
                                    text: urun.beden![index],
                                    selected:
                                        bedenControllers.selectedIndex.value ==
                                            index,
                                    onSelected: (_) => bedenControllers
                                        .selectChip(index, urun),
                                  ),
                                ),
                              ),
                            )
                          : TChoiceChip(
                              text: 'Error',
                              selected: true,
                              onSelected: (value) {},
                            ),
                      //
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BedenControllers extends GetxController {
  // static BedenControllers get instance => Get.find();
  final cartController = CartController.instance;

  var selectedIndex = 0.obs;

  void selectChip(int index, UrunModel urun) {
    selectedIndex.value = index;
    cartController.updateAlreadyAddedProductCount(urun, index);
  }
}




 // Image Slider
                    // ListView.separated(
                    //   separatorBuilder: (_, __) =>
                    //       const SizedBox(width: Sizes.spaceBtwItems),
                    //   itemCount: 4,
                    //   itemBuilder: (_, index) {
                        
                    //     return Container(
                    //         width: 100,
                    //         margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    //         child: Image.network(img));
                    //   },
                    //   scrollDirection: Axis.horizontal,
                    //   padding: const EdgeInsets.only(top: 420),
                    //   shrinkWrap: true,
                    // ),
                    // TRoundedImage(
                    //   width: 80,
                    //   backgroundColor: dark?Colors.black:Colors.white,
                    //   border: Border.all(color: TColors.primary),
                    //   padding: const EdgeInsets.all(Sizes.sm),
                    //   imageUrl: img,
                    //   isNetworkImage: true,

                    // )
