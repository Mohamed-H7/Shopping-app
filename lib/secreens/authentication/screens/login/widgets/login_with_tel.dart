import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/login_controllers.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class LoginWithTelefoneScreen extends StatelessWidget {
  const LoginWithTelefoneScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.LoginFormKeyTel,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: controller.telefoneNum,
              validator: (value) => Validator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: "Telefon Numarası",
                  prefixIcon: Icon(Iconsax.call)),
            ),

            const SizedBox(height: Sizes.spaceBtwInputFields),

            //Sing in btn
            Obx(
              () => controller.isloding.value
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(TColors.primary),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => controller.sendOtp(),
                          child: const Text("Giriş yap")),
                    ),
            ),

            const SizedBox(height: Sizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
