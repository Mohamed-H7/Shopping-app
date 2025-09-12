import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/marka_model.dart';

class MarkaRepository extends GetxController {
  static MarkaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<MarkaModel>> getAllMarka() async {
    try {
      final snapshot = await _db.collection('Markalar').get();
      final list = snapshot.docs
          .map((document) => MarkaModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      print("=====Hata 1 in (MarkaRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (MarkaRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
