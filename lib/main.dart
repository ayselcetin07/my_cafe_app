import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/homePage.dart';
import 'package:provider/provider.dart';
import 'package:my_cafe_app/models/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: 'My Cafe App',
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white, // İmleç rengini beyaz yap
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ), // Varsayılan metin rengini siyah yap
          primarySwatch: Colors.brown,
        ),
        home: HomePage(),
      ),
    );
  }
}
