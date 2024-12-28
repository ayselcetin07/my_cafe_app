import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/loginPage.dart';
import 'package:my_cafe_app/utilities/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Ortak kullanılan InputDecoration
  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
          // Kayıt formu
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Raccoon Cafe\'ye',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 36.0,
                      fontFamily: "Retosta",
                    ),
                  ),
                  Text(
                    'Kayıt Olun!',
                    style: TextStyle(
                      color: AppColors.kirikbeyaz,
                      fontSize: 32.0,
                      fontFamily: "Retosta",
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: _buildInputDecoration('Ad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration:
                                TextDecoration.none, // Alt çizgiyi kaldır
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: _buildInputDecoration('Soyad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration:
                                TextDecoration.none, // Alt çizgiyi kaldır
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: _buildInputDecoration('Email'),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration:
                                TextDecoration.none, // Alt çizgiyi kaldır
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: _buildInputDecoration('Şifre').copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.kirikbeyaz,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration:
                                TextDecoration.none, // Alt çizgiyi kaldır
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          cursorColor: Colors.amber, // İmleç rengi
                          decoration:
                              _buildInputDecoration('Şifre Tekrar').copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.kirikbeyaz,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscureConfirmPassword,
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration:
                                TextDecoration.none, // Alt çizgiyi kaldır
                          ),
                        ),
                        SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Kayıt işlemleri
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Kayıt Ol',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Hesabınız var mı?",
                              style: TextStyle(color: AppColors.kirikbeyaz),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
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
                                "Giriş Yap",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
