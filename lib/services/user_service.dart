import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<void> registerUser(User user) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.103:3000/users/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'password': user.password,
    }),
  );

  if (response.statusCode == 201) {
    print('Kullanıcı başarıyla kaydedildi');
  } else if (response.statusCode == 400) {
    print('Kullanıcı zaten kayıtlı');
  } else {
    throw Exception('Kullanıcı kaydedilemedi');
  }
}

Future<String> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.103:3000/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['token'];
  } else if (response.statusCode == 400) {
    print('Kullanıcı bulunamadı veya yanlış şifre');
    throw Exception('Kullanıcı bulunamadı veya yanlış şifre');
  } else {
    throw Exception('Giriş yapılamadı');
  }
}
