import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_akhir_tpm/screen/login_screen.dart';
import '../models/model.dart';
import '../services/api_service.dart';
import '../services/sharedpref.dart';
import 'profile_screen.dart'; // Import your profile screen file

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  PageController _pageController = PageController();
  List<Product> _searchResults = [];
  ApiService _apiService = ApiService(); // Inisialisasi ApiService

  Future<void> _searchProducts(String query) async {
    List<Product> results = await _apiService.searchProducts(query);
    setState(() {
      _searchResults = results;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari Produk',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            _searchProducts(value);
            setState(() {
              _selectedIndex = 2;
              _pageController.jumpToPage(2);
            });
          },
        ),
        actions: [
          IconButton(
            icon:
                Icon(Icons.logout, color: const Color.fromARGB(255, 255, 0, 0)),
            onPressed: () {
              _logout(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {
              // Tambahkan logika untuk menampilkan chart di sini
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          // Tambahkan halaman yang sesuai di sini
          Center(child: Text('Products Page')),
          Center(child: Text('Promo Page')),
          _buildSearchResults(),
          Center(child: Text('Notifications Page')),
          Center(child: Text('Profile Page')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.ticketAlt),
            label: 'Promo',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(158, 0, 0, 0),
        onTap: _onItemTapped,
      ),
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

  Future<void> _logout(BuildContext context) async {
    await SharedPreferencesService.removeEmail();
    await SharedPreferencesService.removePassword();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
