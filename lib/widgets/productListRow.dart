import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/menu.dart';
import 'package:my_cafe_app/utilities/constants.dart';

class ProductListRow extends StatelessWidget {
  final String name;
  final String description;
  final int Price;
  final String imageUrl;

  ProductListRow(
      {required this.name,
      required this.description,
      required this.Price,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, //start
      children: <Widget>[
        buildProductItemCard(context),
        buildProductItemCard(context),
      ],
    );
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );
      },
      child: Card(
        color: AppColors.kirikbeyaz,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0), // Resmin üstüne boşluk ekle
              child: Container(
                child: Image.network(imageUrl),
                height: 180.0,
                width: MediaQuery.of(context).size.width / 2.2,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              // Resim ile metin arasında boşluk
              child: Text(
                this.name,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 9, 9, 9),
                  decoration: TextDecoration.underline,
                  decorationColor:
                      const Color.fromARGB(255, 0, 0, 0), // Çizginin rengi
                  decorationThickness: 2.0,
                ),
                // Yazıyı ortala
              ),
            ),
          ],
        ),
      ),
    );
  }
}
