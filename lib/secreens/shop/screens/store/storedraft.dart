import 'package:alisveris/utils/constans/enums.dart';
import 'package:alisveris/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../widgets/appbar/appbar.dart';
import '../../../../widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../widgets/images/circular_image.dart';
import '../../../../widgets/search bar/search_bar.dart';
import '../../../../widgets/texts/brand_title_icon.dart';
import '../../../../widgets/texts/section_heading.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: SAppBar(
        title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? Colors.black
                  : Colors.white,
              expandedHeight: 440,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    const SearchContainer(
                      text: 'Serach',
                      showBorder: true,
                      showBackground: false,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),

                    // -- Featured Brands
                    SectionHeading(title: 'Featured Brands', onPressed: () {}),
                    const SizedBox(height: Sizes.spaceBtwItems / 1.5),

                    GridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
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
                                      isNetworkImage: false,
                                      image: "assets/kategoriler/scarf.png",
                                      backgroundColor: Colors.transparent,
                                      overlayColor:
                                          dark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: Sizes.spaceBtwItems / 2),

                                  //text
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const BrandTitleWithVerifiedIcon(
                                          title: 'Nike',
                                          brandTextSize: TextSizes.large,
                                        ),
                                        Text(
                                          '256 Urun',
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
          ];
        },
        body: Container(),
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
