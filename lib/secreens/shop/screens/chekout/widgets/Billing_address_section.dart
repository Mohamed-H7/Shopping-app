import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/address_controller.dart';
import '../../../../../utils/constans/sizes.dart';

class BillingAddresstSection extends StatelessWidget {
  const BillingAddresstSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());

    controller.getAllUserAddresses();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Adres',
                style: Theme.of(context).textTheme.headlineSmall!.apply(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              TextButton(
                  onPressed: () => controller.selectNewAddressPopup(
                      context), //Get.to(() => const UserAddressScreen())
                  child: const Text('değiştirmek'))
            ],
          ),

          Text(
            controller.selectedAddress.value.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: Sizes.spaceBtwItems / 2),

          Row(
            children: [
              const Icon(Icons.phone, color: Colors.grey, size: 16),
              const SizedBox(width: Sizes.spaceBtwItems),
              Text(
                controller.selectedAddress.value.phoneNumber,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ), // Row

          const SizedBox(height: Sizes.spaceBtwItems / 2),

          Row(
            children: [
              const Icon(Icons.location_history, color: Colors.grey, size: 16),
              const SizedBox(width: Sizes.spaceBtwItems),
              Expanded(
                child: Text(
                  controller.selectedAddress.value.address,
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),
            ],
          ), // Row
        ],
      ),
    );
  }
}
