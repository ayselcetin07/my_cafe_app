import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menuItem.dart';

Future<List<MenuItem>> fetchMenuItems(String category) async {
  final response =
      await http.get(Uri.parse('http://192.168.1.103:3000/api/menu/$category'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => MenuItem.fromJson(item)).toList();
  } else {
    throw Exception('Menü öğeleri alınamadı');
  }
}
