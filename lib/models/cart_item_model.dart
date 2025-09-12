class CartItemModel {
  String urunId;
  String title;
  double fiyat;
  String? image;
  int miktar;
  String? markaAd;
  String? beden;
  int bedenIndex;

  /// Constructor
  CartItemModel({
    required this.urunId,
    required this.miktar,
    this.image,
    this.fiyat = 0.0,
    this.title = '',
    this.markaAd,
    this.beden,
    this.bedenIndex = 0,
  });

  /// Empty Cart
  static CartItemModel empty() => CartItemModel(urunId: '', miktar: 0);

  /// Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'productId': urunId,
      'title': title,
      'price': fiyat,
      'image': image,
      'quantity': miktar,
      'brandName': markaAd,
      'beden': beden,
      'bedenIndex': bedenIndex,
    };
  }

  /// Create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      urunId: json['productId'],
      title: json['title'],
      fiyat: json['price'].toDouble(),
      image: json['image'],
      miktar: json['quantity'],
      // variationId: json['variationId'],
      markaAd: json['brandName'],
      beden: json['beden'],
      bedenIndex: json['bedenIndex'] ?? 0,
    );
  }
}
