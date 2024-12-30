import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/ProductList.dart';
import 'package:my_cafe_app/screens/category_list_screen.dart';
import 'package:my_cafe_app/utilities/constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Raccoon Cafe",
          style: TextStyle(
              color: Colors.amber, fontSize: 28, fontFamily: "Retosta"),
        ),
        // elevation: 5, // Gölge derinliği
        //shadowColor: const Color.fromARGB(134, 124, 78, 13),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/images/rakun.jpeg'), // Arka plan resmi
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryListScreen()),
                  );
                },
                child: Text(
                  "Let's Start!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Buton rengi
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
