import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menuItem.dart';
import '../config.dart'; // URL'yi içe aktarıyoruz

class MenuService {
  Future<List<MenuItem>> fetchMenuItems(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/api/menu/$category'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => MenuItem.fromJson(item)).toList();
    } else {
      throw Exception('Menü öğeleri alınamadı');
    }
  }
}
