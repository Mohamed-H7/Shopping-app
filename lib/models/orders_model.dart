import 'package:cloud_firestore/cloud_firestore.dart';

import 'siparis_item_model.dart';

class OrdersModel {
  String id;
  final String useriId;
  final String durum;
  final String siparisNo;
  final String tarih;
  final String adresId;
  final String bankaKartId;
  final double toplam;
  final List<SiparisItem> siparisler;
  // final String? teslimTarihi;

  OrdersModel({
    required this.id,
    this.useriId = '',
    required this.durum,
    required this.siparisNo,
    required this.tarih,
    required this.adresId,
    required this.toplam,
    required this.bankaKartId,
    required this.siparisler,
  });

  static OrdersModel empty() => OrdersModel(
        id: '',
        durum: '',
        siparisNo: '',
        tarih: '',
        adresId: '',
        toplam: 0,
        bankaKartId: '',
        siparisler: [],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Durum': durum,
      'SiparisNo': siparisNo,
      'Tarih': tarih,
      'AdresId': adresId,
      'BankaKartId': bankaKartId,
      'Toplam': toplam,
      'Siparisler': siparisler.map((e) => e.toJson()).toList(),
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> data) {
    return OrdersModel(
      id: data['Id'] as String,
      durum: data['Durum'] as String,
      siparisNo: data['SiparisNo'] as String,
      tarih: data['Tarih'] as String,
      adresId: data['AdresId'] as String,
      bankaKartId: data['BankaKartId'] as String,
      toplam: data['Toplam'] as double,
      siparisler: (data['Siparisler'] as List<dynamic>)
          .map((item) => SiparisItem.fromJson(item))
          .toList(),
    );
  }

  factory OrdersModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrdersModel(
      id: snapshot.id,
      durum: data['Durum'] as String,
      siparisNo: data['SiparisNo'] as String,
      tarih: data['Tarih'] as String,
      adresId: data['AdresId'] as String,
      bankaKartId: data['BankaKartId'] as String,
      toplam: data['Toplam'] as double,
      siparisler: (data['Siparisler'] as List<dynamic>)
          .map((item) => SiparisItem.fromJson(item))
          .toList(),
    );
  }
}
