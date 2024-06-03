import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class ApiService {
  Future<List<Product>> fetchProducts() async {
    final Uri url = Uri.parse('https://api.escuelajs.co/api/v1/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> productsData = json.decode(response.body);
      return productsData.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final Uri url =
        Uri.parse('https://api.escuelajs.co/api/v1/products?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> results =
          data.map((item) => Product.fromJson(item)).toList();
      return results;
    } else {
      throw Exception('Failed to search products');
    }
  }
}
