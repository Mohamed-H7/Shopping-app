// import 'package:alisveris/utils/constans/sizes.dart';
// import 'package:alisveris/widgets/layouts/grid_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../controllers/urunler_controllers.dart';
// import '../../../../controllers/user_controllers.dart';
// import '../../../../utils/constans/colors.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../../../widgets/appbar/appbar.dart';
// import '../../../../widgets/products/product_cards/product_card_vertical.dart';
// import 'search_screen.dart';
// import 'widgets/counter_icon.dart';
// import 'widgets/home_categori.dart';
// import 'widgets/promo_slider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UrunlerController());
//     final userController = Get.put(UserController());
//     final dark = HelperFunctions.isDarkMode(context);

//     final TextEditingController searchController = TextEditingController();

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //mavi bolum:
//             Container(
//               color: TColors.primary,
//               padding: const EdgeInsets.only(bottom: 0), //
//               child: Column(
//                 children: [
//                   //Header
//                   // AppBar(),
//                   SAppBar(
//                     actions: [
//                       CounterIcon(
//                         onPressed: () {},
//                         iconColor: Colors.white,
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
//                     child: Obx(() => Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Merhaba! ",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall!
//                                     .apply(
//                                         color: const Color.fromARGB(
//                                             255, 223, 223, 223))),
//                             Text(userController.user.value.fullName,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headlineSmall!
//                                     .apply(color: Colors.white)),
//                           ],
//                         )),
//                   ),

//                   const SizedBox(height: Sizes.spaceBtwSections),

//                   // Search Bar
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: Sizes.defaultSpace),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: searchController,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: dark ? TColors.dark : TColors.light,
//                               // labelText: 'Ad',
//                               hintText: 'Mağazada Arayınız',
//                               hintStyle: TextStyle(
//                                 color: dark
//                                     ? TColors.light.withOpacity(0.5)
//                                     : TColors.dark.withOpacity(0.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () => Get.to(() => SearchScreen(
//                                 araValue: searchController.text,
//                               )),
//                           icon: const Icon(Iconsax.search_normal),
//                           color: dark ? TColors.dark : TColors.light,
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Sizes.spaceBtwSections),

//                   //Kategoriler
//                   Padding(
//                     padding: const EdgeInsets.only(left: Sizes.defaultSpace),
//                     child: Column(
//                       children: [
//                         //Heading
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Kategoriler',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall!
//                                   .apply(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: Sizes.spaceBtwItems),

//                         //Kategoriler
//                         const HomeCategori(),
//                         //Delet this if fix blue-bar screen size
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: Sizes.spaceBtwSections),
//                 ],
//               ),
//             ),

//             //Body
//             Padding(
//               padding: const EdgeInsets.all(Sizes.defaultSpace),
//               child: Obx(
//                 () => Column(
//                   children: [
//                     const Reklamlar(
//                       banners: [
//                         "assets/banner/banner1.jpeg",
//                         "assets/banner/banner2.jpeg",
//                         "assets/banner/banner3.jpeg",
//                       ],
//                     ),
//                     const SizedBox(height: Sizes.spaceBtwSections),

//                     //En Çok Satılanlar
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'En Çok Satılanlar',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall!
//                               .apply(color: dark ? Colors.white : Colors.black),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: Sizes.spaceBtwItems),

//                     GridLayout(
//                         itemCount: controller.unluUrunler.length, //2
//                         itemBuilder: (_, index) {
//                           final unluUrun = controller.unluUrunler[index];
//                           return ProductCardVertical(
//                             title: unluUrun.Ad,
//                             marka: unluUrun.Marka,
//                             fiyat: unluUrun.Fiyat,
//                             image: unluUrun.image,
//                             urunID: unluUrun.id,
//                           );
//                         }),

//                     const SizedBox(height: Sizes.spaceBtwSections),

//                     //Flaş Ürünler
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Flaş Ürünler',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall!
//                               .apply(color: dark ? Colors.white : Colors.black),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: Sizes.spaceBtwItems),

//                     GridLayout(
//                         itemCount: controller.flashUrunler.length,
//                         itemBuilder: (_, index) {
//                           final flashUrun = controller.flashUrunler[index];
//                           return ProductCardVertical(
//                             title: flashUrun.Ad,
//                             marka: flashUrun.Marka,
//                             fiyat: flashUrun.Fiyat,
//                             image: flashUrun.image,
//                             urunID: flashUrun.id,
//                           );
//                         })
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
