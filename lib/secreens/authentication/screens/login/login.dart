import 'package:alisveris/utils/constans/sizes.dart';
import 'package:alisveris/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/login_with_email.dart';
import 'widgets/login_with_tel.dart';
import 'widgets/toggle_btn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String darkAppLogo = "assets/logo/logo_black.png";
  static const String lightAppLogo = "assets/logo/logo_white.png";

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final indexController = Get.put(SelectedlistControllers());

    final List<Widget> screens = [
      const LoginWithEmailScreen(),
      const LoginWithTelefoneScreen(),
    ];

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: Sizes.appBarHeight,
            left: Sizes.defaultSpace,
            bottom: Sizes.defaultSpace,
            right: Sizes.defaultSpace,
          ),
          child: Column(
            children: [
              //logo:
              Image(
                height: 150, //dark ? TImages.lightAppLogo : TImages.darkAppLogo
                image: AssetImage(dark ? lightAppLogo : darkAppLogo),
              ),
              Text("Tekrar Hoşgeldiniz",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.sm),
              Text("Alışverişinizi tamamlamak için giriş yapınız",
                  style: Theme.of(context).textTheme.bodyMedium),

              //switch btn:
              const SizedBox(height: 20),
              const ToggleBtn(),

              Obx(
                () => IndexedStack(
                  index: indexController.isSelected[1] == true ? 1 : 0,
                  children: screens,
                ),
              ),

              ///
              // form()
            ],
          ),
        ),
      ),
    );
  }
}
