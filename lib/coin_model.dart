class Coin {
  final String name;
  final String imageUrl;
  final double price;

  Coin({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      imageUrl: json['image'],
      price: double.tryParse(json['price']) ?? 0.0,
    );
  }
}
