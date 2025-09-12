import 'package:flutter/material.dart';

import '../../../../utils/constans/enums.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../images/circular_image.dart';
import '../../../texts/brand_title_icon.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData(
      {super.key,
      this.fiyat = '000',
      this.markaAd = 'none',
      this.adet = 0,
      this.markaImage =
          'https://res.cloudinary.com/djguccfjj/image/upload/v1744053039/markalar/scnwh3sfzqtdcwtp3jvh.png'});

  final String fiyat, markaAd, markaImage;
  final int adet;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        const Row(
          children: [
            /// Sale Tag
            // RoundedContainer(
            //   radius: Sizes.sm,
            //   backgroundColor: TColors.secondary.withOpacity(0.8),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: Sizes.sm,
            //     vertical: Sizes.xs,
            //   ),
            //   child: Text(
            //     '25%',
            //     style: Theme.of(context)
            //         .textTheme
            //         .labelLarge!
            //         .apply(color: Colors.black),
            //   ),
            // ),

            // const SizedBox(width: Sizes.spaceBtwItems),

            // /// Old Price
            // Text(
            //   '\$250',
            //   style: Theme.of(context).textTheme.titleSmall!.apply(
            //         decoration: TextDecoration.lineThrough,
            //       ),
            // ),

            // const SizedBox(width: Sizes.spaceBtwItems),

            /// New Price
            // TProductPriceText(
            //   price: fiyat,
            //   isLarge: false,
            // ),
          ],
        ),

        // const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Title
        // ProductTitleText(title: title),

        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Stock Status
        // Row(
        //   children: [
        //     ProductTitleText(
        //         title: (adet == 0) ? 'Durum: tükendi' : 'Durum: mevcut'),
        //     // const SizedBox(width: Sizes.spaceBtwItems),
        //     // Text(
        //     //   (adet == 0) ? 'tükendi' : 'mevcut',
        //     //   style: Theme.of(context).textTheme.titleMedium,
        //     // ),
        //   ],
        // ),

        // const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            CircularImage(
              image: (markaImage != 'null')
                  ? markaImage
                  : 'https://res.cloudinary.com/djguccfjj/image/upload/v1744053039/markalar/scnwh3sfzqtdcwtp3jvh.png',
              width: 32,
              height: 32,
              isNetworkImage: true,
              overlayColor: dark ? Colors.white : Colors.black,
            ),
            BrandTitleWithVerifiedIcon(
              title: markaAd,
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
//'https://res.cloudinary.com/djguccfjj/image/upload/v1744053039/markalar/scnwh3sfzqtdcwtp3jvh.png'
