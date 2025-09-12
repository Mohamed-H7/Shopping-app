import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:alisveris/widgets/products/product_cards/product_card_vertical.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/urunler_controllers.dart';
import '../../../../../utils/constans/sizes.dart';

class MarkaScreen extends StatelessWidget {
  const MarkaScreen({super.key, this.markaID = '', this.title = 'Marka 1'});

  final String markaID, title;

  @override
  Widget build(BuildContext context) {
    final urunController = Get.put(UrunlerController());

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
                        urunController.groupedMarkalar[markaID]?.length ?? 0,
                    itemBuilder: (_, index) {
                      final urun =
                          urunController.groupedMarkalar[markaID]![index];
                      return ProductCardVertical(
                        // title: urun.title,
                        // marka: title,
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
