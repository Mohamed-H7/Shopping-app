import 'package:get/get.dart';

import '../models/categori_model.dart';
import '../repository/categories_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> unUnluCategories = <CategoryModel>[].obs;

  var isloding = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void unUnlu() {
    for (var kategori in allCategories) {
      if (kategori.unUnlu == true) {
        unUnluCategories.add(kategori);
      }
    }
  }

  Future<void> fetchCategories() async {
    try {
      isloding.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      unUnlu();
    } catch (e) {
      print("======== Hata:");
      print(e.toString());
    } finally {
      isloding.value = false;
    }
  }
}
