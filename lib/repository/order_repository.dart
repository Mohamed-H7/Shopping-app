import 'package:alisveris/models/orders_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrdersModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes.';
      }

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) =>
              OrdersModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Address Information. Try again later';
    }
  }

  Future<String> addOrder(OrdersModel order) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentOrder = await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
      return currentOrder.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try again later';
    }
  }
}
