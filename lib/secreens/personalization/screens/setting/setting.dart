import 'package:alisveris/repository/authentication_repository.dart';
import 'package:alisveris/secreens/personalization/screens/profile/profile.dart';
import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../widgets/list_title/user_profile_title.dart';
import '../../../shop/screens/order/order.dart';
import '../address/address.dart';
import '../banka_kartlar/banka_kartlar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkTheme = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: TColors.primary,
                padding: const EdgeInsets.only(bottom: 0), //
                child: Column(
                  children: [
                    //AppBar
                    SAppBar(
                      title: Text("Hesapınız",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: Colors.white)),
                    ),

                    //Profile card
                    const UserProfileTitle(),
                    const SizedBox(height: Sizes.spaceBtwSections),
                  ],
                )),

            //body
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  //Acc setting
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hesap Ayarları",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.apply(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  //

                  ListTile(
                    leading: const Icon(Iconsax.personalcard,
                        size: 28, color: TColors.primary),
                    title: Text("Hesap bilgileri",
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => Get.to(() => const ProfileScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.bag_tick,
                        size: 28, color: TColors.primary),
                    title: Text("Siparişlerim",
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => Get.to(() => const OrderScreens()), //
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.location,
                        size: 28, color: TColors.primary),
                    title: Text("Adreslerim",
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.bank,
                        size: 28, color: TColors.primary),
                    title: Text("Banka Kartlarım",
                        style: Theme.of(context).textTheme.titleMedium),
                    onTap: () => Get.to(() => const UserBankaKartlarScreen()),
                  ),

                  // -- App Settings --
                  const SizedBox(height: Sizes.spaceBtwSections),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Uygulama Ayarları",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.apply(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  ListTile(
                    leading: const Icon(Iconsax.moon,
                        size: 28, color: TColors.primary),
                    title: Text("Karanlık Tema",
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: Switch(
                      value: darkTheme,
                      onChanged: (bool value) {
                        setState(() {
                          darkTheme = value;

                          if (value) {
                            Get.changeThemeMode(ThemeMode.dark);
                          } else {
                            Get.changeThemeMode(ThemeMode.light);
                          }
                        });
                      },
                    ),
                    onTap: () {}, //=> Get.to(() => const UserAddressScreen())
                  ),

                  /// -- Logout Button
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text('Çıkış Yap'),
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
