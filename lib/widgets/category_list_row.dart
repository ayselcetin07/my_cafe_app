import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/menu_screen.dart';

class CategoryListRow extends StatelessWidget {
  final String name;
  final String imageUrl;

  CategoryListRow({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Kenarlardan boşluk ekledik
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuScreen(selectedCategory: name)),
          );
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Kartın kenarlarını oval yap
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Genişliği doldur
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15.0), // Sadece üst kenarları oval yap
                ),
                child: Image.asset(
                  imageUrl,
                  height: 180.0,
                  fit: BoxFit.cover, // Resmi alanı dolduracak şekilde ayarla
                ),
              ),
              Expanded(
                child: Center(
                  // Yazıyı ortalamak için Center widget'ı ekledik
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 9, 9, 9),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color.fromARGB(255, 0, 0, 0),
                        decorationThickness: 2.0,
                      ),
                      textAlign: TextAlign.center, // Metni ortala
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
