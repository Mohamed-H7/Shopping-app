import 'package:alisveris/utils/constans/enums.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/categori_controllers.dart';
import '../../../../controllers/marka_controller.dart';
import '../../../../controllers/urunler_controllers.dart';
import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../../widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../widgets/images/circular_image.dart';
import '../../../../widgets/images_text_widget/virtical_image_text.dart';
import '../../../../widgets/texts/brand_title_icon.dart';
import '../../../../widgets/texts/section_heading.dart';
import '../home/search_screen.dart';
import '../kategoriler/kategori_screen.dart';
import 'widget/marka_screen.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final markaController = Get.put(MarkaController());
    final categoryController = Get.put(CategoryController());
    final urunController = Get.put(UrunlerController());
    final TextEditingController searchController2 = TextEditingController();

    return Scaffold(
      appBar: SAppBar(
        title:
            Text('Mağaza', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                // const SearchContainer(
                //   text: 'Mağazada Arayınız',
                //   showBorder: true,
                //   showBackground: false,
                //   padding: EdgeInsets.zero,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: dark
                                ? TColors.dark
                                : const Color.fromARGB(255, 255, 255, 255),
                            // labelText: 'Ad',
                            hintText: 'Mağazada Arayınız',
                            hintStyle: TextStyle(
                              color: dark
                                  ? TColors.light.withOpacity(0.5)
                                  : TColors.dark.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => SearchScreen(
                              araValue: searchController2.text,
                            )),
                        icon: const Icon(Iconsax.search_normal),
                        color: dark
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 81, 81, 81),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems + 10,
                ),

                //kategori:
                SectionHeading(
                  title: 'Kategoriler',
                  onPressed: () {},
                  showActionButton: false,
                ),
                const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                GridLayout(
                    itemCount: categoryController.allCategories.length,
                    mainAxisExtent: 80,
                    crossAxisCount: 4,
                    itemBuilder: (_, index) {
                      final cat = categoryController.allCategories[index];

                      return VerticalImageText(
                        image: cat.image,
                        title: cat.name,
                        isNetworkImage: true,
                        onTap: () => Get.to(() => KategorilerScreen(
                              title: cat.name,
                              kategoriID: cat.id,
                            )),
                      );
                    }),

                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                // -- Markalar
                SectionHeading(
                  title: 'Markalar',
                  onPressed: () {},
                  showActionButton: false,
                ),
                const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                GridLayout(
                    itemCount: markaController.allMarka.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index) {
                      final marka = markaController.allMarka[index];
                      final adet =
                          urunController.groupedMarkalar[marka.id]?.length ?? 0;

                      return GestureDetector(
                        onTap: () => Get.to(() => MarkaScreen(
                              title: marka.ad,
                              markaID: marka.id,
                            )),
                        child: RoundedContainer(
                          padding: const EdgeInsets.all(Sizes.sm),
                          showBorder: true,
                          backgroundColor: Colors.transparent,
                          child: Row(
                            children: [
                              /// -- Icon here
                              Flexible(
                                child: CircularImage(
                                  width: 55,
                                  height: 55,
                                  isNetworkImage: true,
                                  image: marka.image,
                                  backgroundColor: Colors.transparent,
                                  overlayColor:
                                      dark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: Sizes.spaceBtwItems / 2),

                              //text
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BrandTitleWithVerifiedIcon(
                                      title: marka.ad,
                                      brandTextSize: TextSizes.large,
                                    ),
                                    Text(
                                      '$adet Urun',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//                             width: 56,
//                             height: 56,
//                             padding: const EdgeInsets.all(Sizes.sm),
//                             decoration: BoxDecoration(
//                               color: HelperFunctions.isDarkMode(context)
//                                   ? Colors.black
//                                   : Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Image(
//                               image: const AssetImage(
//                                   "assets/kategoriler/scarf.png"),
//                               color: HelperFunctions.isDarkMode(context)
//                                   ? Colors.white
//                                   : TColors.dark,
//                             ),
//                           ),
