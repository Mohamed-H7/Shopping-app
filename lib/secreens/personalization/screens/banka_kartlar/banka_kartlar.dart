import 'package:alisveris/controllers/kartlar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/CloudHelperFunctions.dart';
import '../../../../widgets/appbar/appbar.dart';
import 'widgets/add_new_cart.dart';
import 'widgets/single_kart.dart';

class UserBankaKartlarScreen extends StatelessWidget {
  const UserBankaKartlarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kartController = Get.put(BankaKartlarController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewBankaKartScreen()),
        child: const Icon(Iconsax.add, color: Colors.white),
      ),
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Banka Kartları',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                key: Key(kartController.refreshData.value.toString()),
                future: kartController.getAllUserBankaKartlar(),
                builder: (context, snapshot) {
                  final response = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (response != null) return response;

                  final bankaKart = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: bankaKart.length,
                    itemBuilder: (_, index) => SingleBankaKart(
                      bankaKart: bankaKart[index],
                      onTap: () => kartController.selectKart(bankaKart[index]),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
