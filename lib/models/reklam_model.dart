import 'package:cloud_firestore/cloud_firestore.dart';

class ReklamModel {
  String id;
  String imageUrl;

  ReklamModel({
    required this.id,
    required this.imageUrl,
  });

  static ReklamModel empty() => ReklamModel(id: '', imageUrl: '');

  Map<String, dynamic> toJson() {
    return {
      'Image': imageUrl,
    };
  }

  factory ReklamModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ReklamModel(
        id: document.id,
        imageUrl: data['path'] ?? '',
      );
    } else {
      return ReklamModel.empty();
    }
  }
}
