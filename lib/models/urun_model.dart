import 'package:cloud_firestore/cloud_firestore.dart';

class UrunModel {
  String id;
  String image;
  String kategori_id;
  String marka_id;
  String title;
  double fiyat;
  List<int>? stock;
  bool flash;
  bool unUnlu;
  List<String>? beden;

  UrunModel({
    required this.id,
    this.image = '',
    this.kategori_id = '',
    this.marka_id = '',
    this.title = '',
    this.fiyat = 0.0,
    this.stock,
    this.unUnlu = false,
    this.flash = false,
    this.beden,
  });

  static UrunModel empty() => UrunModel(id: '');

  Map<String, dynamic> toJson() {
    return {
      'Fiyat': fiyat,
      'Flash': flash,
      'Image': image,
      'Kategori_id': kategori_id,
      'Marka_id': marka_id,
      'Stock': stock ?? [],
      'Title': title,
      'UnUnlu': unUnlu,
      'Beden': beden ?? [],
    };
  }

  factory UrunModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UrunModel(
        id: document.id,
        title: data['Title'] ?? '',
        fiyat: double.parse((data['Fiyat'] ?? 0).toString()),
        flash: data['Flash'] ?? false,
        image: data['Image'] ?? '',
        kategori_id: data['Kategori_id'] ?? '',
        marka_id: data['Marka_id'] ?? '',
        unUnlu: data['UnUnlu'] ?? false,
        beden: data['Beden'] != null ? List<String>.from(data['Beden']) : [],
        stock: data['Stock'] != null ? List<int>.from(data['Stock']) : [],
      );
    } else {
      return UrunModel.empty();
    }
  }
}
