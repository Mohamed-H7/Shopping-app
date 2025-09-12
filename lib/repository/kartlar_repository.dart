import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/kartlar_model.dart';
import 'authentication_repository.dart';

class BankaKartlarRepository extends GetxController {
  static BankaKartlarRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BankaKartlarModel>> fetchUserKartlar() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes.';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('BankaKartlar')
          .get();
      return result.docs
          .map((documentSnapshot) =>
              BankaKartlarModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching BankaKartlar Information. Try again later';
    }
  }

  Future<void> updateSelectedField(String kartId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('BankaKartlar')
          .doc(kartId)
          .update({'SelectedCart': selected});
    } catch (e) {
      throw 'Unable to update your BankaKartlar selection. Try again later';
    }
  }

  Future<String> addBankaKart(BankaKartlarModel bankaKart) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentKart = await _db
          .collection('Users')
          .doc(userId)
          .collection('BankaKartlar')
          .add(bankaKart.toJson());
      return currentKart.id;
    } catch (e) {
      throw 'Something went wrong while saving bankaKart Information. Try again later';
    }
  }
}
