import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_cafe_app/models/user.dart';

class UserService {
  static const String _baseUrl = 'http://192.168.1.103:3000/api/users';

  static Future<User?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['user']);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<void> register(
      String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }
}
