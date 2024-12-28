import 'package:flutter/material.dart';
import 'package:my_cafe_app/models/cart.dart';
import 'package:my_cafe_app/screens/productDetail.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:provider/provider.dart';

class MenuRow extends StatelessWidget {
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  MenuRow({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              name: name,
              description: description,
              price: price.toDouble(),
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.kirikbeyaz, //card yapısının rengi
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black, width: 2), // Border rengi ve kalınlığı
          borderRadius: BorderRadius.circular(8.0), // Köşeleri yuvarlama
        ),
        child: ListTile(
          leading:
              Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
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
                '$price TL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.red),
                onPressed: () {
                  // Sepete ekleme işlemi
                  Provider.of<Cart>(context, listen: false)
                      .addItem(name, price.toDouble(), 1, imageUrl: imageUrl);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
