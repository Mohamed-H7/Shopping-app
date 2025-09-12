import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/marka_controller.dart';
import '../../../../../models/urun_model.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../widgets/images/rounded_image.dart';

class SipItem extends StatelessWidget {
  const SipItem({
    super.key,
    required this.urun,
    required this.beden,
    required this.stock,
  });

  final UrunModel urun;
  final String beden, stock;

  @override
  Widget build(BuildContext context) {
    final markaController = Get.put(MarkaController());

    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          TRoundedImage(
            isNetworkImage: true,
            imageUrl: urun.image,
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(Sizes.sm),
            backgroundColor: HelperFunctions.isDarkMode(context)
                ? TColors.darkGrey
                : TColors.light,
          ),
          const SizedBox(width: Sizes.spaceBtwItems),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        markaController.allMarka
                                .firstWhereOrNull(
                                    (item) => item.id == urun.marka_id)
                                ?.ad ??
                            'null',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium!.apply(),
                      ),
                    ),
                    const SizedBox(width: Sizes.xs),
                    const Icon(Iconsax.verify5,
                        color: TColors.primary, size: Sizes.iconXs),
                  ],
                ),
                Flexible(
                  child: Text(
                    urun.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Beden: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: '$beden \t\t',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: 'Adet: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: stock,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: '\t\tFiyat: ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: "${urun.fiyat.toString()} TL",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
