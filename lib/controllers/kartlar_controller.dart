import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/kartlar_model.dart';
import '../repository/kartlar_repository.dart';
import '../secreens/personalization/screens/banka_kartlar/widgets/add_new_cart.dart';
import '../secreens/personalization/screens/banka_kartlar/widgets/single_kart.dart';
import '../utils/constans/sizes.dart';
import '../utils/helpers/CloudHelperFunctions.dart';
import '../utils/helpers/network_manager.dart';
import '../widgets/texts/section_heading.dart';

class BankaKartlarController extends GetxController {
  static BankaKartlarController get instance => Get.find();

  final kartAd = TextEditingController();
  final kartNo = TextEditingController();
  final bitisTaihi = TextEditingController();
  GlobalKey<FormState> kartformKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<BankaKartlarModel> selectedCart = BankaKartlarModel.empty().obs;
  final bankaKartlarRepository = Get.put(BankaKartlarRepository());

  RxList<BankaKartlarModel> allCarts = <BankaKartlarModel>[].obs;

  Future<List<BankaKartlarModel>> getAllUserBankaKartlar() async {
    try {
      final kartlart = await bankaKartlarRepository.fetchUserKartlar();
      selectedCart.value = kartlart.firstWhere(
        (element) => element.selectedCart,
        orElse: () => BankaKartlarModel.empty(),
      );
      allCarts.assignAll(kartlart);
      return kartlart;
    } catch (e) {
      print("=========== bankaKart Controller: =====");
      print(e);
      return [];
    }
  }

  Future selectKart(BankaKartlarModel newSelectedCart) async {
    try {
      if (selectedCart.value.id.isNotEmpty) {
        await bankaKartlarRepository.updateSelectedField(
            selectedCart.value.id, false);
      }

      newSelectedCart.selectedCart = true;
      selectedCart.value = newSelectedCart;

      await bankaKartlarRepository.updateSelectedField(
          selectedCart.value.id, true);
    } catch (e) {
      print('Error in Selection');
      print(e);
    }
  }

  Future addNewBankaKart() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!kartformKey.currentState!.validate()) {
        return;
      }

      final trimmed = kartNo.text.trim();
      final last4 = trimmed.substring(trimmed.length - 4);

      final bankaKart = BankaKartlarModel(
        id: '',
        kartAd: kartAd.text.trim(),
        kartNo: last4,
        selectedCart: true,
        bitisTaihi: bitisTaihi.text.trim(),
        token: '',
      );

      final id = await bankaKartlarRepository.addBankaKart(bankaKart);

      bankaKart.id = id;
      await selectKart(bankaKart);

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      print("err bankaKart: $e");
    }
  }

  void resetFormFields() {
    kartAd.clear();
    kartNo.clear();
    bitisTaihi.clear();
    kartformKey.currentState?.reset();
  }

  //
  Future<dynamic> selectNewKartlarPopup(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(Sizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                title: 'Banka kartınızı seçiniz',
                showActionButton: false,
              ),
              const SizedBox(height: Sizes.defaultSpace),
              Expanded(
                child: FutureBuilder(
                  future: getAllUserBankaKartlar(),
                  builder: (_, snapshot) {
                    final response = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );
                    if (response != null) return response;

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => SingleBankaKart(
                        bankaKart: snapshot.data![index],
                        onTap: () async {
                          await selectKart(snapshot.data![index]);
                          Get.back();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: Sizes.defaultSpace),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddNewBankaKartScreen()),
                  child: const Text('Yeni kart ekle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
}
