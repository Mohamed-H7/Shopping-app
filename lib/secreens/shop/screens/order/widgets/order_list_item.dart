import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/order_controller.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/helpers/CloudHelperFunctions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../widgets/custom_shapes/containers/rounded_container.dart';
import 'siparis_screen.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    final controller = Get.put(OrdersController());

    return Obx(
      () => FutureBuilder(
          key: Key(controller.refreshData.value.toString()),
          future: controller.getAllUserOrders(),
          builder: (context, snapshot) {
            final response =
                CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
            if (response != null) return response;

            final orders = snapshot.data!;
            return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: Sizes.spaceBtwItems),
              itemBuilder: (_, index) => RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Row 1
                    Row(
                      children: [
                        /// 1 - Icon
                        const Icon(Iconsax.ship),
                        const SizedBox(width: Sizes.spaceBtwItems / 2),

                        /// 2 - Status & Date
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Durum: ${orders[index].durum}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(
                                        color: TColors.primary,
                                        fontWeightDelta: 2),
                              ),
                              // Text
                            ],
                          ),
                        ),

                        //3-icon
                        IconButton(
                            onPressed: () => Get.to(() => SiparisScreen(
                                  siparisID: orders[index].id,
                                )),
                            icon: const Icon(
                              Iconsax.arrow_right_34,
                              size: Sizes.iconSm,
                            ))
                      ],
                    ),
                    const SizedBox(width: Sizes.spaceBtwItems),

                    /// Row 2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.tag),
                              const SizedBox(width: Sizes.spaceBtwItems / 2),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sipariş No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ), // Text
                                    Text(
                                      orders[index].siparisNo,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: Sizes.spaceBtwItems / 2),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sipariş Tarihi',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ), // Text
                                    Text(
                                      orders[index].tarih,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ), // Row
                  ],
                ), // Column
              ),
            );
          }),
    );
  }
}
