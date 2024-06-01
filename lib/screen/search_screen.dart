import 'package:flutter/material.dart';
import '../models/model.dart';
import '../services/api_service.dart';

class searchScreen extends StatefulWidget {
  @override
  _searchScreen createState() => _searchScreen();
}

class _searchScreen extends State<searchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  ApiService _apiService = ApiService(); // Inisialisasi ApiService

  Future<void> _searchProducts(String query) async {
    List<Product> results = await _apiService.searchProducts(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Tambahkan logika logout di sini
            },
          ),
          IconButton(
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              // Tambahkan logika untuk menampilkan chart di sini
            },
          ),
        ],
      ),
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('Tidak ada hasil pencarian'),
      );
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResults[index].title),
            // Tambahkan fungsi lain yang Anda perlukan untuk menampilkan informasi produk
          );
        },
      );
    }
  }
}
