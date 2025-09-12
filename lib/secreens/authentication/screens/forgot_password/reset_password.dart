import 'package:alisveris/secreens/authentication/screens/login/login.dart';
import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.mail});
  final String mail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: TColors.primary, //Colors.green
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.send_1,
                    size: 50,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: Sizes.spaceBtwItems),

                //text
                Text("Şifreniz Gönderildi",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: Sizes.spaceBtwItems),
                Text("($mail) adresine şifre yenileme linkiniz gönderildi.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium),
                Text(
                    "Şifre Yenileme e-postası elinize ulaşmadıysa: Destek ekibiyle (alisveris@destek.com) iletişime geçin",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium),

                const SizedBox(height: Sizes.spaceBtwSections),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: const Text("Tamamlandı")),
                ),
                // SizedBox(
                //   child: TextButton(
                //       onPressed: () => Get.offAll(() => const LoginScreen()),
                //       child: const Text("resend password")),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
