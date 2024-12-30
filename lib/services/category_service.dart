import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

Future<List<Category>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.103:3000/api/categories'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((category) => Category.fromJson(category)).toList();
  } else {
    throw Exception('Kategoriler alınamadı');
  }
}
