import 'package:flutter/material.dart';
import 'package:my_cafe_app/utilities/constants.dart';
import 'package:my_cafe_app/widgets/ProductListRow.dart';

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product List",
          style: TextStyle(color: Colors.black),
        ),
        //  backgroundColor: Color(0xFFA7C957),
        //elevation: 10, // Gölge derinliği
        //shadowColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: AppColors.kirikbeyaz, // Arka plan renginde kullanıldı
        centerTitle: true,
      ),
      body: Container(
        //color: Colors.grey[200],
        color: Color.fromARGB(
            255, 124, 85, 56), // Arka plan rengi burada ayarlanıyor
        child: _buildProductListPage(),
      ),
    );
  }

  _buildProductListPage() {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: ListView.builder(
        itemCount: 5, //

        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFilterWidgets(screenSize);
          } else if (index == 4) {
            return SizedBox(
              height: 12.0,
            );
          } else {
            return _buildProductListRow();
          }
        },
      ),
    );
  }

  _buildFilterWidgets(Size screenSize) {
    return Container(
      margin: EdgeInsets.all(12.0),
      width: screenSize.width,
      child: Card(
        color: AppColors.kirikbeyaz,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildFilterButton("Sırala"),

                //araya çizgi
                Container(
                  color: Colors.black,
                  width: 2.0,
                  height: 24.0,
                ),
                _buildFilterButton("Filtrele"),
              ]),
        ),
      ),
    );
  }

  _buildFilterButton(String title) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Row(
        children: <Widget>[
          Icon(Icons.arrow_drop_down, color: Colors.black),
          SizedBox(width: 2.0),
          Text(title),
        ],
      ),
    );
  }

  _buildProductListRow() {
    return ProductListRow(
        name: "Sıcak İçecekler",
        description: "vöptgöptrög",
        Price: 300,
        imageUrl:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/chorizo-mozarella-gnocchi-bake-cropped-9ab73a3.jpg");
  }
}
