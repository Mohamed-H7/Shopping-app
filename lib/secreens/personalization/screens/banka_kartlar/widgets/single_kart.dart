import 'package:alisveris/controllers/kartlar_controller.dart';
import 'package:alisveris/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../models/kartlar_model.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SingleBankaKart extends StatelessWidget {
  const SingleBankaKart({
    super.key,
    required this.bankaKart,
    required this.onTap,
  });

  final BankaKartlarModel bankaKart;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bankaController = BankaKartlarController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedKartId = bankaController.selectedCart.value.id;
      final selectedKart = selectedKartId == bankaKart.id;
      return InkWell(
        onTap: onTap,
        child: RoundedContainer(
          backgroundImage: const DecorationImage(
            image: AssetImage('assets/icons/card.png'),
            fit: BoxFit.cover,
          ),
          showBorder: true,
          padding: const EdgeInsets.all(Sizes.lg),
          width: double.infinity,
          height: 185,
          backgroundColor: selectedKart
              ? const Color.fromARGB(255, 80, 87, 121).withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedKart
              ? Colors.transparent
              : dark
                  ? TColors.darkerGrey
                  : Colors.grey,
          margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedKart ? Iconsax.tick_circle5 : null,
                  color: TColors.light,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "****   ****   ****  ${bankaKart.kartNo}", //
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kart Sahibinin Adı",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.grey[300]),
                          ),
                          Text(
                            bankaKart.kartAd.capitalize!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Valid Thru",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.grey[300]),
                          ),
                          Text(
                            bankaKart.bitisTaihi,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}


// Text(
//                     "Mohamed Hamdo", //bankaKart.kartAd
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.apply(color: Colors.white),
//                   ),
//                   const SizedBox(height: Sizes.sm / 2),
//                   Text(bankaKart.kartNo,
//                       maxLines: 1, overflow: TextOverflow.ellipsis),
//                   const SizedBox(height: Sizes.sm / 2),
//                   Text(
//                     bankaKart.bitisTaihi,
//                     softWrap: true,
//                   ),
