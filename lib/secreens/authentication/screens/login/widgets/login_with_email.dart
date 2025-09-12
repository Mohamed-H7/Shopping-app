import 'package:alisveris/secreens/authentication/screens/forgot_password/forgot_password.dart';
import 'package:alisveris/secreens/authentication/screens/signup/signup.dart';
import 'package:alisveris/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/login_controllers.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/validators/validation.dart';

class LoginWithEmailScreen extends StatelessWidget {
  const LoginWithEmailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.LoginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: "E-Posta", prefixIcon: Icon(Iconsax.direct_right)),
            ),

            //pass
            const SizedBox(height: Sizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.sifre,
                validator: (value) =>
                    Validator.validateEmptyText('Sifre', value),
                obscureText: controller.SifreSaklamak.value,
                decoration: InputDecoration(
                  labelText: "Şifre",
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.SifreSaklamak.value =
                          !controller.SifreSaklamak.value,
                      icon: Icon(controller.SifreSaklamak.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye)),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields / 2),

            // ree & forget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Beni hatirla
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.BeniHatirla.value,
                          onChanged: (value) => controller.BeniHatirla.value =
                              !controller.BeniHatirla.value),
                    ),
                    const Text("Beni hatirla"),
                  ],
                ),

                //Forget Pass
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text("Şiifreni mi unuttun?"))
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwSections),

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
                          onPressed: () => controller.emailAndPasswordSignIn(),
                          child: const Text("Giriş yap")),
                    ),
            ),

            const SizedBox(height: Sizes.spaceBtwItems),
            //Create acc btn

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text("Üye Ol")),
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
