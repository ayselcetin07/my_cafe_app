import 'package:flutter/material.dart';
import 'package:my_cafe_app/services/category_service.dart';
import 'package:my_cafe_app/models/category.dart';
import 'package:my_cafe_app/widgets/category_list_row.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = CategoryService().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategoriler",
          style: TextStyle(color: Colors.black, fontFamily: "Times New Roman"),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 124, 85, 56),
        child: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No categories found'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var category = snapshot.data![index];
                  return CategoryListRow(
                    name: category.name,
                    imageUrl: category.imageUrl,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
