import 'package:cloud_firestore/cloud_firestore.dart';

class MarkaModel {
  String id;
  String ad;
  String image;

  MarkaModel({
    required this.id,
    required this.ad,
    required this.image,
  });

  static MarkaModel empty() => MarkaModel(id: '', image: '', ad: '');

  Map<String, dynamic> toJson() {
    return {
      'ad': ad,
      'image': image,
    };
  }

  factory MarkaModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return MarkaModel(
        id: document.id,
        ad: data['ad'] ?? '',
        image: data['image'] ?? '',
      );
    } else {
      return MarkaModel.empty();
    }
  }
}
