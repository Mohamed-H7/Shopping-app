import 'package:alisveris/secreens/shop/screens/home/home.dart';
import 'package:alisveris/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

// ignore: unused_import
import 'secreens/personalization/screens/setting/setting.dart';
import 'secreens/shop/screens/card/card.dart';
import 'secreens/shop/screens/store/store.dart';
import 'secreens/shop/screens/wishlist/wishlist.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? Colors.black : Colors.white,
            indicatorColor: darkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(
                  icon: Icon(Iconsax.home), label: "Ana Sayfa"),
              NavigationDestination(icon: Icon(Iconsax.shop), label: "Mağaza"),
              NavigationDestination(
                  icon: Icon(Iconsax.shopping_cart), label: "Sepet"),
              NavigationDestination(
                  icon: Icon(Iconsax.heart), label: "Favoriler"),
              NavigationDestination(icon: Icon(Iconsax.user), label: "Profil"),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    const SettingsScreen()
  ];
}
