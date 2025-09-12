import 'package:alisveris/controllers/kartlar_controller.dart';
import 'package:alisveris/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constans/sizes.dart';
import '../../../../../widgets/appbar/appbar.dart';

class AddNewBankaKartScreen extends StatelessWidget {
  const AddNewBankaKartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bankaController = BankaKartlarController.instance;
    return Scaffold(
      appBar: const SAppBar(
        showBackArrow: true,
        title: Text('Banka Kart Ekle'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: bankaController.kartformKey,
            child: Column(
              children: [
                TextFormField(
                  controller: bankaController.kartAd,
                  validator: (value) => Validator.validateCardHolderName(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.profile_2user),
                    labelText: 'Kart üzerindeki isim',
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                TextFormField(
                  controller: bankaController.kartNo,
                  validator: (value) => Validator.validateCardNumber(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.card),
                    labelText: 'Kart numarası',
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // TextFormField(

                //   validator: (value) =>
                //       Validator.validateEmptyText('bitisTaihi', value),
                //   decoration: const InputDecoration(
                //     prefixIcon: Icon(Iconsax.location),
                //     labelText: 'Son kullanma tarihi',
                //   ),
                // ),
                // const SizedBox(height: Sizes.defaultSpace),
                //
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bankaController.bitisTaihi,
                        validator: (value) =>
                            Validator.validateExpiryDate(value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Son kullanma tarihi",
                            prefixIcon: Icon(Iconsax.calendar)),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // controller: controller.soyad,
                        validator: (value) => Validator.validateCVV(value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Güvenlik kodu",
                            prefixIcon: Icon(Iconsax.lock)),
                      ),
                    ),
                  ],
                ),
                //
                const SizedBox(height: Sizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => bankaController.addNewBankaKart(),
                      child: const Text('Kaydet')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
