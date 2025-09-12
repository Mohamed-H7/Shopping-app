import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/marka_controller.dart';
import '../../../../controllers/urunler_controllers.dart';
import '../../../../controllers/user_controllers.dart';
import '../../../../utils/constans/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../../widgets/layouts/grid_layout.dart';
import '../../../../widgets/products/product_cards/product_card_vertical.dart';
import '../../../shimmer/vertical_product_shimmer.dart';
import 'search_screen.dart';
import 'widgets/home_categori.dart';
import 'widgets/promo_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UrunlerController());
    final userController = Get.put(UserController());
    final markaController = Get.put(MarkaController());
    final dark = HelperFunctions.isDarkMode(context);

    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(children: [
            //mavi bolum:
            Stack(
              // clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 180),
                  decoration: const BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      //Header
                      // AppBar(),
                      SAppBar(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Merhaba!",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(
                                        color: const Color.fromARGB(
                                            255, 223, 223, 223))),
                            Obx(
                              () => Text(userController.user.value.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwSections - 20),

                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.defaultSpace),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text('TRENDIFY',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900)),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      dark ? TColors.dark : TColors.light,
                                  // labelText: 'Ad',
                                  hintText: 'Mağazada Arayınız',
                                  hintStyle: TextStyle(
                                    color: dark
                                        ? TColors.light.withOpacity(0.5)
                                        : TColors.dark.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Get.to(() => SearchScreen(
                                    araValue: searchController.text,
                                  )),
                              icon: const Icon(Iconsax.search_normal),
                              color: dark ? TColors.dark : TColors.light,
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: Sizes.spaceBtwSections + 60),
                    ],
                  ),
                ),
                Positioned(
                    left: 20,
                    right: 20,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: dark ? TColors.dark : TColors.light,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Reklamlar(
                          banners: [
                            // "assets/banner/banner1.jpeg",
                            // "assets/banner/banner2.jpeg",
                            // "assets/banner/banner3.jpeg",
                            "assets/banner/r1.jpg",
                            "assets/banner/r2.jpg",
                            "assets/banner/r3.jpg",
                          ],
                        ),
                      ),
                    )),
              ],
            ),

            //kategoriler
            const Padding(
                padding: EdgeInsets.all(Sizes.defaultSpace),
                child: HomeCategori()),

            //body
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  //En Çok Satılanlar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'En Çok Satılanlar',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: dark ? Colors.white : Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  //
                  Obx(() {
                    if (controller.isloding.value ||
                        markaController.isloding.value)
                      return const VerticalProductShimmer(itemCount: 2);

                    return GridLayout(
                        itemCount: controller.unluUrunler.length, //2
                        itemBuilder: (_, index) {
                          final unluUrun = controller.unluUrunler[index];
                          return ProductCardVertical(
                            // title: unluUrun.title,
                            // marka: markaController.allMarka
                            //         .firstWhereOrNull(
                            //             (item) => item.id == unluUrun.marka_id)
                            //         ?.ad ??
                            //     'null',
                            // fiyat: unluUrun.fiyat,
                            // image: unluUrun.image,
                            // urunID: unluUrun.id,
                            urun: unluUrun,
                          );
                        });
                  }),
                  //
                  const SizedBox(height: Sizes.spaceBtwSections),

                  //Flaş Ürünler
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Flaş Ürünler',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: dark ? Colors.white : Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  Obx(() {
                    if (controller.isloding.value ||
                        markaController.isloding.value)
                      return const VerticalProductShimmer(itemCount: 2);

                    return GridLayout(
                        itemCount: controller.flashUrunler.length,
                        itemBuilder: (_, index) {
                          final flashUrun = controller.flashUrunler[index];
                          return ProductCardVertical(
                            // title: flashUrun.title,
                            // marka: markaController.allMarka
                            //         .firstWhereOrNull(
                            //             (item) => item.id == flashUrun.marka_id)
                            //         ?.ad ??
                            //     'null',
                            // fiyat: flashUrun.fiyat,
                            // image: flashUrun.image,
                            // urunID: flashUrun.id,
                            urun: flashUrun,
                          );
                        });
                  }),
                ],
              ),
            ), //
          ]),
        ),
      ),
    );
  }
}
