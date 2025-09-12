import 'package:alisveris/controllers/urunler_controllers.dart';
import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../models/urun_model.dart';
import '../secreens/loading_screen/loaders.dart';
import '../utils/local_storge/storge.dart';
import 'marka_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt urunMiktariSepete = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
// final variationController = VariationController.instance;

  final markaController = Get.put(MarkaController());
  final urunController = Get.put(UrunlerController());

  CartController() {
    loadCartItems();
    sepetStokController();
  }

// Add items in the cart
  void addToCart(UrunModel product, int bedenIndex) {
    if (urunMiktariSepete.value < 1) {
      // Loaders.customToast(message: 'Miktarı Seçin');
      return;
    }

    // Out of Stock Status
    // if (product.stock < urunMiktariSepete.value) {
    //   Loaders.warningSnackBar(
    //       message: 'Seçili Ürün stoklarımızda kalmamıştır.', title: 'Hata!');
    //   return;
    // }

    if ((product.stock?.length ?? 0) <= bedenIndex ||
        (product.stock?[bedenIndex] ?? 0) < urunMiktariSepete.value) {
      Loaders.warningSnackBar(
        message: 'Seçili Ürün stoklarımızda kalmamıştır.',
        title: 'Hata!',
      );
      return;
    }

    final selectedCartItem =
        convertToCartItem(product, urunMiktariSepete.value, bedenIndex);

    int index = cartItems.indexWhere((cartItems) =>
        cartItems.urunId == selectedCartItem.urunId &&
        cartItems.beden == selectedCartItem.beden); // && add beden cheker

    if (index >= 0) {
      cartItems[index].miktar = selectedCartItem.miktar;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.successSnackBar(title: 'Ürün sepete eklendi.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.urunId == item.urunId && cartItem.beden == item.beden);

    int urunStockta = urunController.tumUrunler
            .firstWhereOrNull((urun) => urun.id == item.urunId)
            ?.stock?[item.bedenIndex] ??
        0;

    //here for add new urun for different beden:
    if (index >= 0) {
      if (cartItems[index].miktar >= urunStockta) {
        Loaders.warningSnackBar(
            message: 'Seçili Ürün stoklarımızda kalmamıştır.', title: 'Hata!');
      } else {
        cartItems[index].miktar += 1;
      }
    } else {
      // cartItems.add(item);

      if (urunStockta <= 0) {
        Loaders.warningSnackBar(
            message: 'Seçili Ürün stoklarımızda kalmamıştır.', title: 'Hata!');
      } else {
        cartItems.add(item);
      }
    }

    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Ürünü Kaldır',
      middleText: 'Bu ürünü kaldırmak istediğinizden emin misiniz?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        // Loaders.successSnackBar(title: 'Ürün Sepetten kaldırıldı.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.urunId == item.urunId && cartItem.beden == item.beden);

    if (index >= 0) {
      if (cartItems[index].miktar > 1) {
        cartItems[index].miktar -= 1;
      } else {
        // Show dialog before completely removing
        cartItems[index].miktar == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }

    updateCart();
  }

// This function converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(
      UrunModel product, int quantity, int bedenIndx) {
    final price = product.fiyat;

    return CartItemModel(
      urunId: product.id,
      title: product.title,
      fiyat: price,
      miktar: quantity,
      bedenIndex: bedenIndx, // ✅ تمت الإضافة هنا
      image: product.image,
      markaAd: markaController.allMarka
              .firstWhereOrNull((item) => item.id == product.marka_id)
              ?.ad ??
          'null',
      beden: (product.beden == []) ? 'null' : product.beden![bedenIndx],
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.fiyat) * item.miktar.toDouble();
      calculatedNoOfItems += item.miktar;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  //here
  int getProductQuantityInCart(String productId, {int bedenIndex = 0}) {
    String urunBedeni = urunController.tumUrunler
            .firstWhereOrNull((urun) => urun.id == productId)
            ?.beden![bedenIndex] ??
        '';

    final foundItem = cartItems
        .where((item) => item.urunId == productId && item.beden == urunBedeni)
        .fold(0, (previousValue, element) => previousValue + element.miktar);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.urunId == productId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.miktar;
  }

  void clearCart() {
    urunMiktariSepete.value = 0;
    cartItems.clear();
    updateCart();
  }

  /// -- Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(UrunModel product, int bedenIndex) {
    urunMiktariSepete.value =
        getProductQuantityInCart(product.id, bedenIndex: bedenIndex);
  }

  void sepetStokController() {
    List<CartItemModel> itemsToRemove = [];

    for (var item in cartItems) {
      final urun = urunController.tumUrunler
          .firstWhereOrNull((urun) => urun.id == item.urunId);

      if (urun == null) continue;

      int bedenIndx = item.bedenIndex;
      if ((urun.stock?.length ?? 0) <= bedenIndx) continue;

      final int availableStock = urun.stock?[bedenIndx] ?? 0;

      if (availableStock <= 0) {
        itemsToRemove.add(item);
      } else if (item.miktar > availableStock) {
        item.miktar = availableStock;
      }
    }

    cartItems.removeWhere((item) => itemsToRemove.contains(item));

    updateCart();
  }
}
