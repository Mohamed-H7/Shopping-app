import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/address_model.dart';
import '../repository/address_repository.dart';
import '../secreens/personalization/screens/address/add_new_address.dart';
import '../secreens/personalization/screens/address/widgets/single_address.dart';
import '../utils/constans/sizes.dart';
import '../utils/helpers/CloudHelperFunctions.dart';
import '../utils/helpers/network_manager.dart';
import '../widgets/texts/section_heading.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final addr = TextEditingController();
  GlobalKey<FormState> addressformKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  RxList<AddressModel> allAdrs = <AddressModel>[].obs;

  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      print("${selectedAddress.value.id}s");
      allAdrs.assignAll(addresses);
      return addresses;
    } catch (e) {
      print("=========== address Controller: =====");
      print(e);
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      print('Error in Selection');
      print(e);
    }
  }

  Future addNewAddresses() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!addressformKey.currentState!.validate()) {
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        selectedAddress: true,
        address: addr.text.trim(),
      );

      final id = await addressRepository.addAddress(address);

      address.id = id;
      await selectAddress(address);

      refreshData.toggle();

      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      print("err adres: $e");
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    addr.clear();
    addressformKey.currentState?.reset();
  }

  //
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
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
                title: 'Adres Seçiniz',
                showActionButton: false,
              ),
              const SizedBox(height: Sizes.defaultSpace),
              Expanded(
                child: FutureBuilder(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    final response = CloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                    );
                    if (response != null) return response;

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => SingleAddress(
                        address: snapshot.data![index],
                        onTap: () async {
                          await selectAddress(snapshot.data![index]);
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
                  onPressed: () => Get.to(() => const AddNewAddressScreen()),
                  child: const Text('Yeni adres ekle'),
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
