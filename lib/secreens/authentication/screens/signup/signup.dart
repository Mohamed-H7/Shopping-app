import 'package:alisveris/utils/constans/sizes.dart';
import 'package:alisveris/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/singup_controllers.dart';
import '../../../../utils/constans/colors.dart';
import '../../../../widgets/appbar/appbar.dart';
// import 'signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    String firesSifre = "";
    return Scaffold(
      appBar: const SAppBar(
        showBackArrow: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                //title
                Text(
                  "Merhaba,",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text("hesap oluştur, indirimleri kaçırma!",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: Sizes.spaceBtwSections),

                //form
                Form(
                    key: controller.singupFormKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.ad,
                                validator: (value) =>
                                    Validator.validateEmptyText('Ad', value),
                                expands: false,
                                decoration: const InputDecoration(
                                    labelText: "Ad",
                                    prefixIcon: Icon(Iconsax.user)),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: controller.soyad,
                                validator: (value) =>
                                    Validator.validateEmptyText('Soyad', value),
                                expands: false,
                                decoration: const InputDecoration(
                                    labelText: "Soyad",
                                    prefixIcon: Icon(Iconsax.user)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        //Kullanici
                        TextFormField(
                          controller: controller.kullaniciAd,
                          validator: (value) => Validator.validateEmptyText(
                              'Kullanıcı Ad', value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: "Kullanıcı Ad",
                              prefixIcon: Icon(Iconsax.user_edit)),
                        ),
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        //mail
                        TextFormField(
                          controller: controller.email,
                          validator: (value) => Validator.validateEmail(value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: "E-Posta",
                              prefixIcon: Icon(Iconsax.direct)),
                        ),
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        //Telefon Numarası
                        TextFormField(
                          controller: controller.telefon,
                          validator: (value) =>
                              Validator.validatePhoneNumber(value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: "Telefon Numarası",
                              prefixIcon: Icon(Iconsax.call)),
                        ),
                        const SizedBox(height: Sizes.spaceBtwInputFields),

                        //sifre
                        Obx(
                          () => TextFormField(
                            onChanged: (value) {
                              firesSifre = value;
                            },
                            controller: controller.sifre,
                            validator: (value) =>
                                Validator.validatePassword(value),
                            expands: false,
                            obscureText: controller.SifreSaklamak.value,
                            decoration: InputDecoration(
                              labelText: "Şifre",
                              prefixIcon: const Icon(Iconsax.password_check),
                              suffixIcon: IconButton(
                                  onPressed: () => controller.SifreSaklamak
                                      .value = !controller.SifreSaklamak.value,
                                  icon: Icon(controller.SifreSaklamak.value
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye)),
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.spaceBtwInputFields),
                        Obx(
                          () => TextFormField(
                            controller: controller.sifre2,
                            validator: (value) =>
                                Validator.validatePasswordsimilarity(
                                    value, firesSifre),
                            expands: false,
                            obscureText: controller.SifreSaklamak2.value,
                            decoration: InputDecoration(
                              labelText: "Şifreyi tekrar giriniz",
                              prefixIcon: const Icon(Iconsax.password_check),
                              suffixIcon: IconButton(
                                  onPressed: () => controller.SifreSaklamak2
                                      .value = !controller.SifreSaklamak2.value,
                                  icon: Icon(controller.SifreSaklamak2.value
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye)),
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.spaceBtwSections),

                        //Sing in btn
                        Obx(
                          () => controller.isloding.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      TColors.primary),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () => controller
                                          .signup(), //Get.to(() => const SignupState())
                                      child: const Text("Üye Ol")),
                                ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
