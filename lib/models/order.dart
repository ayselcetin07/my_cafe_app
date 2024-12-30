class Order {
  final String item;
  final int quantity;
  final double price;
  final String status;

  Order(
      {required this.item,
      required this.quantity,
      required this.price,
      this.status = 'pending'});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      item: json['item'],
      quantity: json['quantity'],
      price: json['price'],
      status: json['status'],
    );
  }
}
