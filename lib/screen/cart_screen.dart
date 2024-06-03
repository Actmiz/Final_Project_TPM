import 'package:flutter/material.dart';
import '../models/model.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int totalPrice = 0;
  Map<int, int> quantityMap = {}; // Map untuk menyimpan jumlah item per id

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    int sum = 0;
    widget.cartItems.forEach((product) {
      int quantity = quantityMap[product.id] ?? 1; // Default quantity = 1
      sum += product.price * quantity;
    });
    setState(() {
      totalPrice = sum;
    });
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Checkout berhasil!'),
      ),
    );
  }

  void _incrementItem(int productId) {
    setState(() {
      quantityMap.update(productId, (value) => value + 1,
          ifAbsent: () => 1); // Tambah 1 ke jumlah item
      _calculateTotalPrice();
    });
  }

  void _decrementItem(int productId) {
    setState(() {
      if (quantityMap[productId]! > 1) {
        quantityMap.update(productId,
            (value) => value - 1); // Kurangi 1 dari jumlah item, minimal 1
        _calculateTotalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                Product product = widget.cartItems[index];
                int quantity =
                    quantityMap[product.id] ?? 1; // Ambil jumlah item dari Map
                return ListTile(
                  leading: Image.network(
                    product.images[0],
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${product.price}'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              _decrementItem(product.id);
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _incrementItem(product.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$ $totalPrice'),
                ElevatedButton(
                  onPressed: _checkout,
                  child: Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
