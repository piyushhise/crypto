class CryptoModel {
  final String name;
  final String iconUrl;
  final double price;

  CryptoModel({
    required this.name,
    required this.iconUrl,
    required this.price,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'],
      iconUrl: json['iconUrl'],
      price: double.tryParse(json['price']) ?? 0.0,
    );
  }
}
