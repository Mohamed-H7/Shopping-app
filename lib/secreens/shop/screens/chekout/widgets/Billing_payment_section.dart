import 'package:alisveris/widgets/texts/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/kartlar_controller.dart';
import '../../../../../utils/constans/sizes.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankaKartlarController());

    controller.getAllUserBankaKartlar();
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            title: "Ödeme Yöntemi",
            buttonTitle: "değiştirmek",
            onPressed: () => controller.selectNewKartlarPopup(
                context), //=> Get.to(() => const UserBankaKartlarScreen())
          ),
          // const SizedBox(height: Sizes.spaceBtwItems / 2),
          Row(
            children: [
              // const RoundedContainer(
              //   width: 60,
              //   height: 40,
              //   padding: EdgeInsets.all(Sizes.sm),
              //   child: Image(
              //     image: AssetImage('assets/icons/card.png'),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              const Icon(Iconsax.card),
              const SizedBox(width: Sizes.spaceBtwItems / 2),
              Text(
                "**** ${controller.selectedCart.value.kartNo}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
