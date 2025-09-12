import 'package:alisveris/widgets/appbar/appbar.dart';
import 'package:alisveris/widgets/images/circular_image.dart';
import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/user_controllers.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: const SAppBar(
        showBackArrow: true,
        title: Text("Profil"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircularImage(
                      image: "assets/images/user-profile.png",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),

              /// Heading Profile Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profil Bilgileri",
                    style: Theme.of(context).textTheme.headlineSmall!.apply(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: Sizes.spaceBtwItems),
              ProfileMenu(
                title: 'Ad Soayd',
                value: controller.user.value.fullName,
              ),
              ProfileMenu(
                title: 'Kullanici Ad',
                value: controller.user.value.username,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),

              /// Heading Personal Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kişisel Bilgiler",
                    style: Theme.of(context).textTheme.headlineSmall!.apply(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'E-posta',
                value: controller.user.value.email,
              ),
              ProfileMenu(
                title: 'Telefon numarası',
                value: controller.user.value.phoneNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
