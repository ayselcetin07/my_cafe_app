import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_cafe_app/screens/login_screen.dart';
import 'package:my_cafe_app/services/user_service.dart';
import 'package:my_cafe_app/utilities/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
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
                          controller: firstNameController, // Controller eklendi
                          decoration: _buildInputDecoration('Ad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: lastNameController, // Controller eklendi
                          decoration: _buildInputDecoration('Soyad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: emailController, // Controller eklendi
                          decoration: _buildInputDecoration('Email'),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: passwordController, // Controller eklendi
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
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller:
                              confirmPasswordController, // Controller eklendi
                          cursorColor: Colors.amber,
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
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await UserService.register(
                                  firstNameController.text,
                                  lastNameController.text,
                                  emailController.text,
                                  passwordController.text,
                                );
                                // Kayıt başarılı, giriş ekranına yönlendir
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              } catch (e) {
                                // Kayıt hatasını yönet
                                print('Kayıt başarısız: $e');
                              }
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
                                      builder: (context) => LoginScreen()),
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
