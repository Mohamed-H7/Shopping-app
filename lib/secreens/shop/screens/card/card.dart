import 'package:alisveris/secreens/shop/screens/chekout/chekout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/cart_controller.dart';
import '../../../../utils/constans/sizes.dart';
import 'widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SepetController());
    final controller = CartController.instance;
    // final bool btn = controller.sepet.isEmpty;

    // var toplam = controller.toplam.value.toStringAsFixed(2);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sepet',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Obx(() {
          if (controller.cartItems.isEmpty) {
            return const Center(
              child: Text("Sepete ürün yok"),
            );
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Sizes.defaultSpace),
                child: CartItems(),
              ),
            );
          }
        }),
        bottomNavigationBar: Obx(
          () => controller.cartItems.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(Sizes.defaultSpace),
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const ChekoutScreen()),
                    child: Text(
                        "Sepeti onayla ${controller.totalCartPrice.value.toStringAsFixed(2)} TL"),
                  )),
        ));
  }
}

// btn
//               ? const Text("")
//               : ElevatedButton(
//                   onPressed: () => Get.to(() => const ChekoutScreen()),
//                   child: Text("Ödeme $toplam TL")),
