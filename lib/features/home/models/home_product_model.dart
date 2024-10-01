class ProductDataModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;
  final String imageUrl;
  final bool? isWishlisted;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.imageUrl,
      this.isWishlisted = false});

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        quantity: json['quantity'],
        category: json['category'],
        imageUrl: json['image_url'],
        isWishlisted: json['isWishlisted']);
  }
}
