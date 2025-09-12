import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:alisveris/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/urunler_controllers.dart';
import '../../../../utils/constans/sizes.dart';

class KategorilerScreen extends StatelessWidget {
  const KategorilerScreen(
      {super.key, this.kategoriID = '', this.title = 'Kategori 1'});

  final String kategoriID, title;

  @override
  Widget build(BuildContext context) {
    final urunController = Get.put(UrunlerController());
    // final markaController = Get.put(MarkaController());

    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                GridLayout(
                    itemCount:
                        urunController.groupedCategories[kategoriID]?.length ??
                            0,
                    itemBuilder: (_, index) {
                      final urun =
                          urunController.groupedCategories[kategoriID]![index];
                      return ProductCardVertical(
                        // title: urun.title,
                        // marka: markaController.allMarka
                        //         .firstWhereOrNull(
                        //             (item) => item.id == urun.marka_id)
                        //         ?.ad ??
                        //     'null',
                        // fiyat: urun.fiyat,
                        // image: urun.image,
                        // urunID: urun.id,
                        urun: urun,
                      );
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
