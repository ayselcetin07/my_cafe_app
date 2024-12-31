import 'package:flutter/material.dart';
import 'package:my_cafe_app/models/menuItem.dart';
import 'package:my_cafe_app/screens/productDetail.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:my_cafe_app/models/cart.dart';

class MenuRow extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  MenuRow({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory MenuRow.fromJson(Map<String, dynamic> json) {
    return MenuRow(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              menuItem: MenuItem(
                  name: name,
                  description: description,
                  price: price,
                  imageUrl: imageUrl),
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.kirikbeyaz,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading:
              Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(
            name,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          subtitle: Text(
            description,
            style: TextStyle(color: Colors.blue),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${price} TL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.red),
                onPressed: () {
                  Provider.of<Cart>(context, listen: false)
                      .addItem(name, price, 1, imageUrl: imageUrl);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
