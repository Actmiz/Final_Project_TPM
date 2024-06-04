import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/model.dart';

class ProductGrid extends StatefulWidget {
  final Function(Product) addToCart;

  ProductGrid({required this.addToCart});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  late Future<List<Product>> futureProducts;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureProducts = apiService.fetchProducts();
  }

  String _getValidImageUrl(List<String> images) {
    if (images.isNotEmpty && Uri.tryParse(images[0])?.hasAbsolutePath == true) {
      return images[0];
    } else {
      return 'https://dummyimage.com/150'; // Placeholder URL alternatif
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF7AA37D), // Set background color of the card
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        products[index].image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://dummyimage.com/150', // Placeholder URL alternatif
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              products[index].title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow:
                                  TextOverflow.ellipsis, // Handle long text
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () => widget.addToCart(products[index]),
                            color: Colors.white,
                            iconSize: 24,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '\$${products[index].price}',
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromARGB(255, 230, 223, 223)),
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
