import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

Future<List<Order>> fetchOrders() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.103:3000/orders'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((order) => Order.fromJson(order)).toList();
  } else {
    throw Exception('Siparişler alınamadı');
  }
}
