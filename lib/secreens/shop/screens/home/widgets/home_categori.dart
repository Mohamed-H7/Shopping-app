import 'package:alisveris/controllers/categori_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/images_text_widget/virtical_image_text.dart';
import '../../../../shimmer/categori_shimmer.dart';
import '../../kategoriler/kategori_screen.dart';

class HomeCategori extends StatelessWidget {
  const HomeCategori({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isloding.value) return const CategoryShimmer();

      final categories = categoryController.unUnluCategories;

      return SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // يوزع العناصر بالتساوي
          children: categories.map((category) {
            return VerticalImageText(
              image: category.image,
              title: category.name,
              isNetworkImage: true,
              onTap: () => Get.to(() => KategorilerScreen(
                    title: category.name,
                    kategoriID: category.id,
                  )),
            );
          }).toList(),
        ),
      );
    });
  }
}
