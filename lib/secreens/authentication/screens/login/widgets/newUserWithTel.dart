import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../controllers/login_controllers.dart';
import '../../../../../utils/constans/colors.dart';
import '../../../../../utils/constans/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../../widgets/appbar/appbar.dart';

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({super.key});

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
            children: [
              //title
              Text(
                "Hesabınız başarıyla oluşturuldu",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text("Lütfen bilgilerinizi giriniz",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: Sizes.spaceBtwSections),

              //form
              Form(
                  key: controller.newUserForm,
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
                        controller: controller.kullanici,
                        validator: (value) =>
                            Validator.validateEmptyText('Kullanıcı Ad', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Kullanıcı Ad",
                            prefixIcon: Icon(Iconsax.user_edit)),
                      ),
                      const SizedBox(height: Sizes.spaceBtwInputFields),

                      //mail
                      TextFormField(
                        controller: controller.newEmail,
                        validator: (value) => Validator.validateEmail(value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "E-Posta",
                            prefixIcon: Icon(Iconsax.direct)),
                      ),

                      const SizedBox(height: Sizes.spaceBtwSections),

                      //Devam Ediniz
                      Obx(
                        () => controller.isloding.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    TColors.primary),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.saveTelAccInformation(),
                                    child: const Text("Devam Ediniz"))),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
