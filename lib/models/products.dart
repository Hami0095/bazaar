class Product {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final String description;
  bool isFavourite;
  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    this.isFavourite = false,
  });
}
