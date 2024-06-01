class Product {
  final String name;
  final int price;

  const Product({
    required this.name,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'price': int price} => Product(name: name, price: price),
      _ => throw const FormatException('Failed to load products.'),
    };
  }
}