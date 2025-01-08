import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import 'login_screen.dart';
import 'menu_screen.dart'; // MenuScreen'i içe aktarın
import 'package:my_cafe_app/utilities/constants.dart';
import '../utilities/validators.dart'; // Validators dosyasını import ediyoruz

class RegisterScreen extends StatefulWidget {
  final String selectedCategory;

  RegisterScreen({required this.selectedCategory});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

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

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        User user = User(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        await UserService().registerUser(user);
        print('Kayıt başarılı');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen(selectedCategory: widget.selectedCategory)),
        );
      } catch (e) {
        print('Kayıt başarısız: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt başarısız: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rakun.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 16.0,
            child: IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuScreen(
                          selectedCategory: widget.selectedCategory)),
                );
              },
            ),
          ),
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
                          controller: _firstNameController,
                          decoration: _buildInputDecoration('Ad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Adınızı giriniz';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: _buildInputDecoration('Soyad'),
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Soyadınızı giriniz';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: _buildInputDecoration('Email'),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: AppColors.kirikbeyaz,
                            decoration: TextDecoration.none,
                          ),
                          validator: validateEmail,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
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
                          validator: validatePassword,
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration:
                              _buildInputDecoration('Şifre Tekrar').copyWith(
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
                          validator: (value) => validateConfirmPassword(
                              value, _passwordController.text),
                        ),
                        SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: _register,
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
                                      builder: (context) => LoginScreen(
                                          selectedCategory:
                                              widget.selectedCategory)),
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
