import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../controllers/login_controllers.dart';
import '../../../../../../utils/constans/colors.dart';
import '../../../../../../utils/validators/validation.dart';
import '../../../../../../widgets/appbar/appbar.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
              Text("Doğrulama kodu başarıyla gönderildi",
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                  "Lütfen ${controller.telefoneNum.text} numaranıza gönderilen doğrulama kodunu giriniz.",
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: Sizes.spaceBtwSections),

              //Text filed
              Form(
                key: controller.LoginFormCode,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.code,
                  validator: (value) => Validator.validateOTPcode(value),
                  decoration: const InputDecoration(
                      labelText: "Doğrulama kodu",
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
                            onPressed: () => controller.verifyOtp(),
                            child: const Text("Kontrol Et")),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
