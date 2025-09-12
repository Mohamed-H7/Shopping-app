import 'dart:convert';

import 'package:alisveris/models/urun_model.dart';
import 'package:alisveris/repository/urunler_repository.dart';
import 'package:get/get.dart';

import '../utils/local_storge/storge.dart';

class SepetController extends GetxController {
  static SepetController get instance => Get.find();

  final sepet = <String, bool>{}.obs;
  RxDouble toplam = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initSepet();
  }

  Future<void> initSepet() async {
    final json = LocalStorage.instance().readData('sepet');
    if (json != null) {
      final storedSepet = jsonDecode(json) as Map<String, dynamic>;
      sepet.assignAll(
          storedSepet.map((key, value) => MapEntry(key, value as bool)));

      await _calculateInitialTotal();
    }
  }

  Future<void> _calculateInitialTotal() async {
    final products =
        await UrunlerRepository.instance.getSepetProducts(sepet.keys.toList());

    toplam.value = products.fold(0.0, (sum, product) => sum + product.fiyat);
  }

  bool inSepet(String productId) {
    return sepet[productId] ?? false;
  }

  void toggleSepetProduct(String productId, double productPrice) {
    if (!sepet.containsKey(productId)) {
      sepet[productId] = true;
      toplam.value += productPrice;
      saveSepetToStorage();
    } else {
      LocalStorage.instance().removeData(productId);
      sepet.remove(productId);
      toplam.value -= productPrice;
      saveSepetToStorage();
      sepet.refresh();
    }
  }

  void saveSepetToStorage() {
    final encodedSepet = json.encode(sepet);
    LocalStorage.instance().saveData('sepet', encodedSepet);
  }

  Future<List<UrunModel>> sepetProducts() async {
    return await UrunlerRepository.instance
        .getSepetProducts(sepet.keys.toList());
  }
}
