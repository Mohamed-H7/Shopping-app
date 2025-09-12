import 'dart:convert';

import 'package:alisveris/models/urun_model.dart';
import 'package:alisveris/repository/urunler_repository.dart';
import 'package:get/get.dart';

import '../utils/local_storge/storge.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  void initFavorites() {
    final json = LocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
    } else {
      LocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    LocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<UrunModel>> favoriteProducts() async {
    return await UrunlerRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
