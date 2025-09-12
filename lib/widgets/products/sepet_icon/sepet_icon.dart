import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/sepet_controller.dart';

class EkleIcon extends StatelessWidget {
  const EkleIcon({
    super.key,
    required this.productId,
    required this.fiyat,
  });

  final String productId;
  final double fiyat;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SepetController());
    return Obx(
      () => IconButton(
        icon: controller.inSepet(productId)
            ? const Icon(Iconsax.minus)
            : const Icon(Iconsax.add),
        color: Colors.white,
        onPressed: () => controller.toggleSepetProduct(productId, fiyat),
      ),
    );
  }
}
