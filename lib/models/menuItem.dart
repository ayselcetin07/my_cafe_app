class MenuItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  MenuItem(
      {required this.name,
      required this.description,
      required this.price,
      required this.imageUrl});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }
}
