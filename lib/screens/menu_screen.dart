import 'package:flutter/material.dart';

import 'package:my_cafe_app/models/category.dart';
import 'package:my_cafe_app/models/menuItem.dart';
import 'package:my_cafe_app/screens/cart_screen.dart';
import 'package:my_cafe_app/services/category_service.dart';
import 'package:my_cafe_app/services/menu_service.dart';
import 'package:my_cafe_app/widgets/menuRow.dart';
import 'package:my_cafe_app/screens/loginPage.dart';
import 'package:my_cafe_app/utilities/constants.dart';

class MenuScreen extends StatefulWidget {
  final String selectedCategory;

  MenuScreen({required this.selectedCategory});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String selectedCategory;
  late Future<List<MenuItem>> _menuItems;
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    _menuItems = fetchMenuItems(selectedCategory);
    _categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menü",
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
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: AppColors.brown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<Category>>(
              future: _categories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No categories found'));
                } else {
                  return Container(
                    height: 50.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data!.map((category) {
                        return buildCategoryButton(category.name);
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: FutureBuilder<List<MenuItem>>(
                future: _menuItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No menu items found'));
                  } else {
                    return ListView(
                      children: snapshot.data!.map((menuItem) {
                        return MenuRow(
                          name: menuItem.name,
                          description: menuItem.description,
                          price: menuItem.price,
                          imageUrl: menuItem.imageUrl,
                        );
                      }).toList(),
                    );
                  }
                },
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
            _menuItems = fetchMenuItems(selectedCategory);
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
