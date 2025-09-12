import 'package:alisveris/utils/helpers/helper_functions.dart';
import 'package:alisveris/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/address_controller.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../controllers/kartlar_controller.dart';
import '../../../../controllers/order_controller.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../card/widgets/cart_items.dart';
import 'widgets/Billing_address_section.dart';
import 'widgets/Billing_payment_section.dart';

class ChekoutScreen extends StatelessWidget {
  const ChekoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    // final controller = SepetController.instance;
    final controller = CartController.instance;
    // var toplam = controller.toplam.value.toStringAsFixed(2);

    final orderController = Get.put(OrdersController());
    final adrsController = Get.put(AddressController());
    final bankaKartController = Get.put(BankaKartlarController());

    return Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            'Sipariş incelemesi',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                //items in cart
                const CartItems(
                  showAddRemoveBtn: false,
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                RoundedContainer(
                  padding: const EdgeInsets.all(Sizes.md),
                  showBorder: true,
                  backgroundColor: dark ? Colors.black : Colors.white,
                  child: Column(
                    children: [
                      /// Order Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Toplam Tutar',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              '${controller.totalCartPrice.value.toStringAsFixed(2)} TL',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),

                      const SizedBox(height: Sizes.spaceBtwItems / 2),

                      //divider
                      const Divider(),
                      // const SizedBox(height: Sizes.spaceBtwItems),

                      //Ödeme Yöntemi
                      // Column(
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           "Ödeme Yöntemi",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .headlineSmall!
                      //               .apply(),
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //       ],
                      //     ),

                      //     const SizedBox(height: Sizes.spaceBtwItems / 2),
                      //     Row(
                      //       children: [
                      //         const Icon(Iconsax.wallet),
                      //         const SizedBox(width: Sizes.spaceBtwItems / 2),
                      //         Text(
                      //           'Kapıda ödeme',
                      //           style: Theme.of(context).textTheme.bodyLarge,
                      //         ),
                      //       ],
                      //     ), // Row
                      //   ],
                      // ),

                      const BillingPaymentSection(),
                      const SizedBox(height: Sizes.spaceBtwItems),

                      //
                      const BillingAddresstSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: ElevatedButton(
              onPressed: () => orderController.addNewOrder(
                  adrsController.selectedAddress.value.id,
                  bankaKartController.selectedCart.value.id,
                  controller.totalCartPrice.value, //
                  UniqueKey().toString()), //basarli odeme sayfsi
              child: Text(
                  "Ödeme ${controller.totalCartPrice.value.toStringAsFixed(2)} TL")),
        ));
  }
}
