import 'package:alisveris/models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/urunler_controllers.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../widgets/custom_shapes/containers/rounded_container.dart';
import 'item.dart';

class SiparisItems extends StatelessWidget {
  const SiparisItems({
    super.key,
    required this.order,
  });

  final OrdersModel order;

  @override
  Widget build(BuildContext context) {
    // final orderController = Get.put(OrdersController());
    final urunlerController = Get.put(UrunlerController());

    return RoundedContainer(
      padding: const EdgeInsets.all(Sizes.md),
      showBorder: true,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: order.siparisler.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: Sizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final siparisItem = order.siparisler[index];
          final item = urunlerController.tumUrunler.firstWhereOrNull(
            (urun) => urun.id == siparisItem.urunId,
          );
          if (item == null) {
            return const Text('Ürün bulunamadı');
          }

          return Column(
            children: [
              SipItem(
                urun: item,
                beden: siparisItem.beden,
                stock: siparisItem.miktar.toString(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
