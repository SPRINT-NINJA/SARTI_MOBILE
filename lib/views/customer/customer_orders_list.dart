import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/customer/customer_orders_details.dart';
import 'package:sarti_mobile/views/customer/review_product_costumer.dart';

class CustomerOrdersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de pedidos simulada
    final orders = [
      {
        'date': '15 de octubre del 2024',
        'imagePath': 'assets/logo/ICON-SARTI.png',
        'productName': 'Paquete de Cake-Topper con cupcakes',
        'quantity': '1 Unidad',
        'status': 'Pendiente',
      },
      {
        'date': '12 de octubre del 2024',
        'imagePath': 'assets/logo/ICON-SARTI.png',
        'productName': 'Set de Decoración de Pasteles',
        'quantity': '2 Unidades',
        'status': 'Entregado',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Acción del menú
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('LISTA DE PEDIDOS'),
            Image.asset(
              'assets/logo/ICON-SARTI.png',
              height: 40,
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/delivery/successful_delivery.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 8),
          _buildFeedbackCard(context),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Pendiente o Entregado...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // Lógica de búsqueda
                print('Texto buscado: $value');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.orange.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(
              'assets/delivery/successful_delivery.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Un producto espera tu opinión',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewProductoCustomer(),
                  ),
                );
              },
              child: const Text(
                'Dar tu opinión',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, String> order) {
    final statusColor = order['status'] == 'Pendiente' ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(
              order['imagePath']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order['date']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    order['productName']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order['quantity']!,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          order['status']!,
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            print("Volver a comprar");
                          },
                          child: const Text(
                            'Volver a comprar',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerOrdersDetails(
                                  purchaseData: {
                                    'date': order['date']!,
                                    'imagePath': order['imagePath']!,
                                    'productName': order['productName']!,
                                    'price': '250',
                                    'total': '250',
                                    'orderNumber': '15',
                                    'deliveryType': 'Envío',
                                    'quantity': order['quantity']!,
                                    'status': order['status']!,
                                  },
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Ver compra',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
