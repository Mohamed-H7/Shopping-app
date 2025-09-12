import 'package:cloud_firestore/cloud_firestore.dart';

class BankaKartlarModel {
  String id;
  final String kartAd;
  final String kartNo;
  final String bitisTaihi;
  final String token;
  bool selectedCart;

  BankaKartlarModel({
    required this.id,
    required this.kartAd,
    required this.kartNo,
    required this.bitisTaihi,
    required this.token,
    this.selectedCart = true,
  });

  static BankaKartlarModel empty() => BankaKartlarModel(
        id: '',
        kartAd: '',
        kartNo: '',
        bitisTaihi: '',
        token: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Kart_Ad': kartAd,
      'Kart_No': kartNo,
      'Bitis_Tarihi': bitisTaihi,
      'SelectedCart': selectedCart,
      'Token': token,
    };
  }

  factory BankaKartlarModel.fromMap(Map<String, dynamic> data) {
    return BankaKartlarModel(
      id: data['Id'] as String,
      kartAd: data['Kart_Ad'] as String,
      kartNo: data['Kart_No'] as String,
      bitisTaihi: data['Bitis_Tarihi'] as String,
      token: data['Token'] as String,
      selectedCart: data['SelectedCart'] as bool,
    );
  }

  factory BankaKartlarModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BankaKartlarModel(
      id: snapshot.id,
      kartAd: data['Kart_Ad'] ?? '',
      kartNo: data['Kart_No'] ?? '',
      bitisTaihi: data['Bitis_Tarihi'] ?? '',
      token: data['Token'] ?? '',
      selectedCart: data['SelectedCart'] as bool,
    );
  }
}
