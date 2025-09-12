import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:alisveris/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/urunler_controllers.dart';
import '../../../../utils/constans/sizes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen(
      {super.key, this.title = 'Arama sonuçları', required this.araValue});

  final String araValue, title;

  @override
  Widget build(BuildContext context) {
    final urunController = Get.put(UrunlerController());
    // final markaController = Get.put(MarkaController());
    urunController.search(araValue);
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
                    itemCount: urunController.aramaUrurnler.length,
                    itemBuilder: (_, index) {
                      final urun = urunController.aramaUrurnler[index];
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
