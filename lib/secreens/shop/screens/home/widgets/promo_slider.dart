import 'package:alisveris/controllers/home_controllers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/reklamlar_controller.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../widgets/images/rounded_image.dart';
import '../../../../shimmer/shimmer.dart';
// import 'reklam_page.dart';

class Reklamlar extends StatelessWidget {
  const Reklamlar({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeControllers());
    final reklamController = Get.put(ReklamlarController());

    //
    return Obx(() {
      if (reklamController.isloding.value)
        return const ShimmerEffect(
          width: double.infinity,
          height: 220,
        );
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                // height: 110,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index)),
            items: reklamController.allreklamlar.map((reklam) {
              return TRoundedImage(
                  imageUrl: reklam.imageUrl, isNetworkImage: true);
            }).toList(),
          ),
          const SizedBox(height: Sizes.spaceBtwItems - 5),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < reklamController.allreklamlar.length; i++)
                  Container(
                    width: 9,
                    height: 9,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: controller.courselCurrentIndex.value == i
                          ? TColors.primary
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
    //
  }
}
