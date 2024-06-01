import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/model.dart';

class ApiService {
  Future<void> fetchProducts() async {
    final Uri url = Uri.parse('https://api.escuelajs.co/api/v1/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Data berhasil diambil
      final List<dynamic> productsData = json.decode(response.body);

      // Gunakan data productsData sesuai kebutuhan Anda
      print(productsData);
    } else {
      // Gagal mengambil data
      print('Gagal mengambil data. Status code: ${response.statusCode}');
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
      print('Gagal mencari produk. Status code: ${response.statusCode}');
      return [];
    }
  }
}
