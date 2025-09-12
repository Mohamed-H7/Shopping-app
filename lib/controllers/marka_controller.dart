import 'package:get/get.dart';

import '../models/marka_model.dart';
import '../repository/marka_repository.dart';

class MarkaController extends GetxController {
  static MarkaController get instance => Get.find();

  final _markaRepository = Get.put(MarkaRepository());
  RxList<MarkaModel> allMarka = <MarkaModel>[].obs;

  var isloding = false.obs;

  @override
  void onInit() {
    fetchMarkalar();     
    super.onInit();
  }

  Future<void> fetchMarkalar() async {
    try {
      isloding.value = true;
      final marklar = await _markaRepository.getAllMarka();

      allMarka.assignAll(marklar);
    } catch (e) {
      print("======== Hata:");
      print(e.toString());
    } finally {
      isloding.value = false;
    }
  }
}
