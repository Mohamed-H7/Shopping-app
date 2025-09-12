import 'package:get/get.dart';

import '../models/reklam_model.dart';
import '../repository/reklamlar_repository.dart';

class ReklamlarController extends GetxController {
  static ReklamlarController get instance => Get.find();

  final _reklamlarRepository = Get.put(ReklamlarRepository());
  RxList<ReklamModel> allreklamlar = <ReklamModel>[].obs;

  var isloding = false.obs;

  @override
  void onInit() {
    fetchReklamlar2();
    for (var element in allreklamlar) {
      print("hero");
      print(element.imageUrl);
    }
    super.onInit();
  }

  Future<void> fetchReklamlar2() async {
    try {
      isloding.value = true;
      final reklamlar = await _reklamlarRepository.fetchReklamlar();

      allreklamlar.assignAll(reklamlar);
    } catch (e) {
      print("======== Hata in fetchReklamlar2:");
      print(e.toString());
    } finally {
      isloding.value = false;
    }
  }
}
