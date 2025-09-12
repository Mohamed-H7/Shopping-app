import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/address_controller.dart';
import '../../../../../controllers/kartlar_controller.dart';
import '../../../../../controllers/order_controller.dart';
import '../../../../../models/address_model.dart';
import '../../../../../models/kartlar_model.dart';
import '../../../../../models/orders_model.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../widgets/appbar/appbar.dart';
import '../../../../../widgets/custom_shapes/containers/rounded_container.dart';
import 'siparis_items.dart';

class SiparisScreen extends StatelessWidget {
  const SiparisScreen({super.key, required this.siparisID});

  final String siparisID;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(OrdersController());
    final bankaController = Get.put(BankaKartlarController());
    final adrsController = Get.put(AddressController());
    // adrsController.getAllUserAddresses();

    return Obx(() {
      final matchedOrder = controller.allOrders.firstWhere(
        (order) => order.id == siparisID,
        orElse: () => OrdersModel.empty(),
      );
      final matchedKart = bankaController.allCarts.firstWhere(
        (kart) => kart.id == matchedOrder.bankaKartId,
        orElse: () => BankaKartlarModel.empty(),
      );
      final matchedAdrs = adrsController.allAdrs.firstWhere(
        (adrs) => adrs.id == matchedOrder.adresId,
        orElse: () => AddressModel.empty(),
      );
      if (matchedAdrs.name == '' || matchedKart.kartNo == '') {
        adrsController.getAllUserAddresses();
        bankaController.getAllUserBankaKartlar();
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            matchedOrder.siparisNo,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          //
          child: Column(
            children: [
              RoundedContainer(
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
                                'Durum:  ${matchedOrder.durum}',
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
                                      matchedOrder.siparisNo,
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
                                      matchedOrder.tarih,
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
              const SizedBox(height: Sizes.spaceBtwItems),
              SiparisItems(
                order: matchedOrder,
              ), //siparisID
              const SizedBox(height: Sizes.spaceBtwItems),
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
                        Text('${matchedOrder.toplam.toStringAsFixed(2)} TL',
                            style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),

                    const SizedBox(height: Sizes.spaceBtwItems / 2),

                    //divider
                    const Divider(),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ödeme Yöntemi',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            const Icon(Iconsax.card),
                            const SizedBox(width: Sizes.spaceBtwItems / 2),
                            Text(
                              "**** ${matchedKart.kartNo}", //
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    //
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adres',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        Text(
                          matchedAdrs.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),

                        const SizedBox(height: Sizes.spaceBtwItems / 2),

                        Row(
                          children: [
                            const Icon(Icons.phone,
                                color: Colors.grey, size: 16),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            Text(
                              matchedAdrs.phoneNumber, //telefon
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ), // Row

                        const SizedBox(height: Sizes.spaceBtwItems / 2),

                        Row(
                          children: [
                            const Icon(Icons.location_history,
                                color: Colors.grey, size: 16),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            Expanded(
                              child: Text(
                                matchedAdrs.address, //adrs
                                style: Theme.of(context).textTheme.bodyMedium,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ), // Row
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
