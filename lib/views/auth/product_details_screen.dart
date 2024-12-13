import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/services/product/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/views/customer/shopping_scree.dart';

class ProductDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final List<String> additionalImages;

  const ProductDetailScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.additionalImages = const [],
  }) : super(key: key);

  Future<void> _handlePurchase(BuildContext context) async {
    ProductService productService = ProductService();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userRole = prefs.getString('role');

    if (token == null) {
      _showAlertDialog(
        context,
        'Error',
        'Debes iniciar sesión para realizar una compra.',
      );
      return;
    }

    if (userRole != 'COMPRADOR') {
      _showAlertDialog(
        context,
        'Acceso denegado',
        'Solo los usuarios con el rol de "COMPRADOR" pueden realizar compras.',
      );
      return;
    }

    var response = await productService.addProductToCart(id);
    if (response) {
      context.pushNamed(ShoppingCartScreen.name);
    } else {
      _showAlertDialog(
        context,
        'Error',
        'Por favor verifique su cuenta antes de realizar una compra y no agregue productos de diferentes vendedores al carrito.',
      );
    }
  }


  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: \$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Descripción:',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              if (additionalImages.isNotEmpty) ...[
                const Text(
                  'Imágenes adicionales:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: additionalImages.map((imgUrl) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () => _handlePurchase(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Comprar ahora',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
