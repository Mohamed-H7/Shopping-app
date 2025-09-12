class SiparisItem {
  final String urunId;
  final String beden;
  final int miktar;

  SiparisItem({
    required this.urunId,
    required this.beden,
    required this.miktar,
  });

  Map<String, dynamic> toJson() => {
        'urunId': urunId,
        'beden': beden,
        'miktar': miktar,
      };

  factory SiparisItem.fromJson(Map<String, dynamic> json) => SiparisItem(
        urunId: json['urunId'],
        beden: json['beden'],
        miktar: json['miktar'],
      );
}
