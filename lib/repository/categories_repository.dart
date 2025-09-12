import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/categori_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db
          .collection('Categories')
          // .where('unlu', isEqualTo: true)
          // .limit(4)
          .get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      print("=====Hata 1 in (CategoryRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (CategoryRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
