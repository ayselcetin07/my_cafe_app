import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_cafe_app/models/category.dart';
import 'package:my_cafe_app/models/menuItem.dart';
import 'package:my_cafe_app/models/cart.dart';
import 'package:my_cafe_app/screens/cart_screen.dart';
import 'package:my_cafe_app/screens/login_screen.dart';
import 'package:my_cafe_app/services/category_service.dart';
import 'package:my_cafe_app/services/menu_service.dart';
import 'package:my_cafe_app/widgets/menuRow.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
    _menuItems = MenuService().fetchMenuItems(selectedCategory);
    _categories = CategoryService().fetchCategories();
  }

  void _scrollToSelectedCategory(List<Category> categories) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = categories
          .indexWhere((category) => category.name == selectedCategory);
      if (index != -1) {
        _scrollController.animateTo(
          index *
              100.0, // Her bir kategori butonunun genişliğine göre ayarlayın
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menü",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Times New Roman",
          ),
        ),
        backgroundColor: AppColors.kirikbeyaz,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 3,
                      top: 2,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen(selectedCategory: selectedCategory)),
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToSelectedCategory(snapshot.data!);
                  });
                  return Container(
                    height: 50.0,
                    child: ListView(
                      controller: _scrollController,
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
            _menuItems = MenuService().fetchMenuItems(selectedCategory);
            _categories.then((categories) {
              _scrollToSelectedCategory(categories);
            });
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
