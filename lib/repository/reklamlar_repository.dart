import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/reklam_model.dart';

class ReklamlarRepository extends GetxController {
  static ReklamlarRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ReklamModel>> fetchReklamlar() async {
    try {
      final snapshot = await _firestore
          .collection('Reklamlar')
          .where('aktif', isEqualTo: true) // جلب الإعلانات الفعالة فقط
          .get();

      final list = snapshot.docs
          .map((document) => ReklamModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      print("=====Hata  in (ReklamlarRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (ReklamlarRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
