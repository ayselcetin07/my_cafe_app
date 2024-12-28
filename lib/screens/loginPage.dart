import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/registerPage.dart'; // RegisterPage import edin
import 'package:my_cafe_app/utilities/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Arka plan resmi
          // Arka plan resmi
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rakun.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Bulanıklaştırma efekti
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5.0, sigmaY: 5.0), // Bulanıklık derecesi
            child: Container(
              color: Colors.black.withOpacity(0.5), // Opak arka plan
            ),
          ),
          // Geri butonu
          Positioned(
            top: 40.0,
            left: 16.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Login formu
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    " Raccoon Cafe'ye  ",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 36.0,
                      //  fontWeight: FontWeight.bold,
                      fontFamily: "Retosta",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Hoşgeldiniz!',
                    style: TextStyle(
                        color: AppColors.kirikbeyaz,
                        fontSize: 32.0,
                        //  fontWeight: FontWeight.bold,
                        fontFamily: "Retosta"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Kullanıcı Adı/E-mail',
                      labelStyle: TextStyle(color: AppColors.kirikbeyaz),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: TextStyle(color: AppColors.kirikbeyaz),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      labelStyle: TextStyle(color: AppColors.kirikbeyaz),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: AppColors.kirikbeyaz),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      // Giriş işlemleri
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Hesabınız yok mu?',
                        style: TextStyle(color: AppColors.kirikbeyaz),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 1.5,
                          ),
                        ),
                        child: Text(
                          'Kaydol',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
