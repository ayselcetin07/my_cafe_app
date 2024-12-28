import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/cartPage.dart';
import 'package:my_cafe_app/screens/loginPage.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:my_cafe_app/widgets/menuRow.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Menü",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.kirikbeyaz,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              // Login sayfasına yönlendirme
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 124, 85, 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  buildCategoryButton('Sıcak İçecekler'),
                  buildCategoryButton('Soğuk İçecekler'),
                  buildCategoryButton('Kahvaltı'),
                  buildCategoryButton('Tatlı'),
                  buildCategoryButton('Burger'),
                  buildCategoryButton('Pizza'),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  MenuRow(
                    name: 'Kahve',
                    description: 'Lezzetli sıcak kahve',
                    price: 15,
                    imageUrl:
                        'https://media.istockphoto.com/id/915365534/tr/foto%C4%9Fraf/siyah-arduvaz-arka-plan-%C3%BCzerine-beyaz-fincan-kahve-espresso.jpg?s=612x612&w=0&k=20&c=7Ci33A4Wd52yyIqSAhD18vHKlcHz3Z19eBkQuGRhTBk=',
                  ),
                  MenuRow(
                    name: 'Çay',
                    description: 'Demlenmiş çay',
                    price: 10,
                    imageUrl:
                        'https://i.lezzet.com.tr/images-xxlarge-secondary/ac-karnina-cay-icmek-zararli-mi-fe626678-237e-4407-a88e-5693bf434a71.jpg',
                  ),
                  MenuRow(
                    name: 'salata',
                    description: 'harika salata',
                    price: 10,
                    imageUrl:
                        'https://d17wu0fn6x6rgz.cloudfront.net/img/w/tarif/mgt/beyaz-peynirli-akdeniz-salatasi-4.webp',
                  ),
                  MenuRow(
                    name: 'espresso',
                    description: 'Lezzetli sıcak kahve',
                    price: 15,
                    imageUrl:
                        'https://media.istockphoto.com/id/915365534/tr/foto%C4%9Fraf/siyah-arduvaz-arka-plan-%C3%BCzerine-beyaz-fincan-kahve-espresso.jpg?s=612x612&w=0&k=20&c=7Ci33A4Wd52yyIqSAhD18vHKlcHz3Z19eBkQuGRhTBk=',
                  ),
                  MenuRow(
                    name: 'ıhlamur',
                    description: 'Demlenmiş çay',
                    price: 10,
                    imageUrl:
                        'https://i.lezzet.com.tr/images-xxlarge-secondary/ac-karnina-cay-icmek-zararli-mi-fe626678-237e-4407-a88e-5693bf434a71.jpg',
                  ),
                  MenuRow(
                    name: 'ton balıklı salata',
                    description: 'harika salata',
                    price: 10,
                    imageUrl:
                        'https://d17wu0fn6x6rgz.cloudfront.net/img/w/tarif/mgt/beyaz-peynirli-akdeniz-salatasi-4.webp',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String title) {
    final isSelected = selectedCategory == title;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedCategory = title;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.amber : AppColors.kirikbeyaz,
          foregroundColor: isSelected ? AppColors.kirikbeyaz : Colors.blue,
          side: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
