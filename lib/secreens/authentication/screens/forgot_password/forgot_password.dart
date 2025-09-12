import 'package:alisveris/controllers/forget_password_contoller.dart';
import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/validators/validation.dart';
import '../../../../widgets/appbar/appbar.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: const SAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //heading
              Text("Şifre Yenileme",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                  "Şifre yenileme bağlantısını gönderebilmemiz için e-posta adresinize ihtiyacımız var.",
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: Sizes.spaceBtwSections),

              //Text filed
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator: (value) => Validator.validateEmail(value),
                  decoration: const InputDecoration(
                      labelText: "E-Posta",
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              //Submit btn
              Obx(
                () => controller.isloding.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(TColors.primary),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () =>
                                controller.sendPasswordResetEmail(),
                            child: const Text("Göndermek")),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
