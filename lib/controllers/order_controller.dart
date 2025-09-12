import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/orders_model.dart';
import '../models/siparis_item_model.dart';
import '../repository/order_repository.dart';
import '../repository/urunler_repository.dart';
import '../secreens/authentication/screens/message/message.dart';
import '../utils/helpers/network_manager.dart';
import '../utils/local_storge/storge.dart';
import 'cart_controller.dart';
import 'urunler_controllers.dart';

class OrdersController extends GetxController {
  static OrdersController get instance => Get.find();

  final cartController = CartController.instance;
  final orderRepository = Get.put(OrderRepository());

  final urunRepository = Get.put(UrunlerRepository());
  final urunController = Get.put(UrunlerController());

  RxList<OrdersModel> allOrders = <OrdersModel>[].obs;

  // Bugun Tarihi
  final DateTime now = DateTime.now();

  RxBool refreshData = true.obs;

  Future<List<OrdersModel>> getAllUserOrders() async {
    try {
      final orders = await orderRepository.fetchUserOrders();

      allOrders.assignAll(orders);

      return orders;
    } catch (e) {
      print("=========== getAllUserOrders Controller: =====");
      print(e);
      return [];
    }
  }

  Future addNewOrder(
      String adrsId, String bnkId, double toplm, String siparisNo) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final formattedDate = DateFormat('yyyy-MM-dd').format(now);

      final List<SiparisItem> siparisler = cartController.cartItems.map((item) {
        return SiparisItem(
          urunId: item.urunId,
          beden: item.beden ?? '',
          miktar: item.miktar,
        );
      }).toList();

      final order = OrdersModel(
          id: '',
          durum: 'Yolda',
          siparisNo: siparisNo,
          tarih: formattedDate,
          adresId: adrsId,
          toplam: toplm,
          bankaKartId: bnkId,
          siparisler: siparisler);

      // ignore: unused_local_variable
      final kaydet = await orderRepository.addOrder(order);

      //
      for (final item in siparisler) {
        final urun = urunController.tumUrunler.firstWhereOrNull(
          (u) => u.id == item.urunId,
        );

        if (urun != null && urun.stock != null && urun.beden != null) {
          final updatedStockList = List<int>.from(urun.stock!); 
          final bedenList = urun.beden!;

          final index = bedenList.indexOf(item.beden);

          if (index != -1 && index < updatedStockList.length) {
            updatedStockList[index] = (updatedStockList[index] - item.miktar)
                .clamp(0, double.infinity)
                .toInt();

            await urunRepository.updateUrunStock(urun.id, updatedStockList);
            urun.stock = updatedStockList;
          } else {
            print("⚠️ Beden '${item.beden}' bulunamadı veya stock uyumsuz.");
          }
        }
      }
      //

      refreshData.toggle();

      cartController.clearCart();
      LocalStorage.instance().removeData("cartItems");
      // sepetController.toplam.value = 0.0;
      // print(sepetController.toplam.value);

      Get.off(() => MessageScreen(
            not: '',
            msg: 'Ödeme başarıyla tamamlandı.',
            onPressed: () => Get.back(),
          ));
    } catch (e) {
      print("err addNewOrder: $e");
    }
  }
}
