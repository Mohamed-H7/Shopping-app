import 'package:alisveris/controllers/favorite_controller.dart';
import 'package:alisveris/utils/constans/sizes.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/helpers/CloudHelperFunctions.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../../widgets/icon/circular_icon.dart';
import '../../../../widgets/products/product_cards/product_card_vertical.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    // final markaController = Get.put(MarkaController());
    return Scaffold(
      appBar: SAppBar(
        title: Text(
          'Favoriler',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      const emptyW = Center(
                        child: Text("Favorilerde ürün yok"),
                      );
                      //, nothingFound: emptyW

                      final response =
                          CloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, nothingFound: emptyW);
                      if (response != null) return response;

                      final urunler = snapshot.data!;
                      return GridLayout(
                          itemCount: urunler.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                                // title: urunler[index].title,
                                // marka: markaController.allMarka
                                //         .firstWhereOrNull((item) =>
                                //             item.id == urunler[index].marka_id)
                                //         ?.ad ??
                                //     'null',
                                // fiyat: urunler[index].fiyat,
                                // image: urunler[index].image,
                                // urunID: urunler[index].id,
                                urun: urunler[index],
                              ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
