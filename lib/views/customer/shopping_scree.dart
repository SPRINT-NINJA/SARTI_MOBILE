import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';

class ShoppingCartScreen extends StatelessWidget {
  final List<CartItem> items = [
    CartItem(
      name: 'Pulsera de correa de amistad sobre Bob y Patricio Estrella',
      imageUrl:
          'https://via.placeholder.com/150', // URL temporal para la imagen
      price: 300.0,
      quantity: 1,
      isAvailable: true,
    ),
    CartItem(
      name: 'Pulsera de correa de amistad sobre Bob y Patricio Estrella',
      imageUrl: 'https://via.placeholder.com/150',
      price: 300.0,
      quantity: 1,
      isAvailable: true,
    ),
    CartItem(
      name: 'Pulsera de correa de amistad sobre Bob y Patricio Estrella',
      imageUrl: 'https://via.placeholder.com/150',
      price: 300.0,
      quantity: 1,
      isAvailable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        items.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tu carrito'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(item.imageUrl, width: 80, height: 80),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text('Cantidad: ${item.quantity} unidad'),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    item.isAvailable
                                        ? 'Disponible'
                                        : 'No Disponible',
                                    style: TextStyle(
                                      color: item.isAvailable
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            // Lógica para remover el item
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Productos', style: TextStyle(fontSize: 16)),
                Text('\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                // Acción para continuar compra
              },
              child: Text('Continuar Compra', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final bool isAvailable;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.isAvailable,
  });
}
