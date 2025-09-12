import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/urun_model.dart';

class UrunlerRepository extends GetxController {
  static UrunlerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<UrunModel>> getAllUrunler() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final list = snapshot.docs
          .map((document) => UrunModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      print("=====Hata 1 in (UrunlerRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (UrunlerRepository)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<UrunModel>> getFavouriteProducts(List<String> productIds) async {
    if (productIds.isEmpty) {
      return [];
    }

    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => UrunModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      print("=====Hata 1 in (UrunlerRepository:getFavouriteProducts)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (UrunlerRepository:getFavouriteProducts)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      print("===Hata burada");
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<UrunModel>> getSepetProducts(List<String> productIds) async {
    if (productIds.isEmpty) {
      return [];
    }

    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => UrunModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      print("=====Hata 1 in (UrunlerRepository:getSepetProducts)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } on PlatformException catch (e) {
      print("=====Hata 2 in (UrunlerRepository:getSepetProducts)======");
      print(e.code);
      throw 'Something went wrong. Please try again';
    } catch (e) {
      print("===Hata burada");
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateUrunStock(String urunId, List<int> stock) async {
    try {
      await _db.collection('Products').doc(urunId).update({'Stock': stock});
    } catch (e) {
      throw 'Unable to updateUrunStock. Try again later';
    }
  }
}
