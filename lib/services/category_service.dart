import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../config.dart'; // URL'yi içe aktarıyoruz

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/api/categories'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Kategoriler alınamadı');
    }
  }
}
