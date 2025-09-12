import 'package:get/get.dart';

import '../models/urun_model.dart';
import '../repository/urunler_repository.dart';
import 'marka_controller.dart';

class UrunlerController extends GetxController {
  static UrunlerController get instance => Get.find();

  final _urunRepository = Get.put(UrunlerRepository());
  RxList<UrunModel> tumUrunler = <UrunModel>[].obs;
  RxList<UrunModel> unluUrunler = <UrunModel>[].obs;
  RxList<UrunModel> flashUrunler = <UrunModel>[].obs;
  RxMap<String?, RxList<UrunModel>> groupedCategories =
      <String?, RxList<UrunModel>>{}.obs;
  RxMap<String?, RxList<UrunModel>> groupedMarkalar =
      <String?, RxList<UrunModel>>{}.obs;

  final markaController = Get.put(MarkaController());

  RxList<UrunModel> aramaUrurnler = <UrunModel>[].obs;

  var isloding = false.obs;

  @override
  void onInit() {
    fetchUrunler();
    super.onInit();
  }

  //
  void groupProductsByCategory() {
    for (var product in tumUrunler) {
      final kategoriId = product.kategori_id;

      if (!groupedCategories.containsKey(kategoriId)) {
        groupedCategories[kategoriId] = <UrunModel>[].obs;
      }

      groupedCategories[kategoriId]!.add(product);
    }
  }

  void groupProductsByMarkalar() {
    for (var product in tumUrunler) {
      final markaiId = product.marka_id;

      if (!groupedMarkalar.containsKey(markaiId)) {
        groupedMarkalar[markaiId] = <UrunModel>[].obs;
      }

      groupedMarkalar[markaiId]!.add(product);
    }
  }

  void search(String val) {
    aramaUrurnler.clear();
    for (var product in tumUrunler) {
      if (product.title.contains(val)) {
        aramaUrurnler.add(product);
        // print("aramak Buldu");
      }
      // print("aramak Bulamadi");
      // aramaUrurnler.add(product);
    }
  }

  Future<void> fetchUrunler() async {
    try {
      isloding.value = true;
      final urunler = await _urunRepository.getAllUrunler();
      tumUrunler.assignAll(urunler);

      groupProductsByCategory();
      groupProductsByMarkalar();

      //filter un unlu urunler
      unluUrunler
          .assignAll(tumUrunler.where((urun) => urun.unUnlu).take(4).toList());
      //filter flash urunler
      flashUrunler
          .assignAll(tumUrunler.where((urun) => urun.flash).take(4).toList());
    } catch (e) {
      print("======== Hata: urun contol");
      print(e.toString());
    } finally {
      isloding.value = false;
    }
  }
}
