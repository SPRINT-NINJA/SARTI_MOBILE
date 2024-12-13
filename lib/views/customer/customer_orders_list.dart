import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:sarti_mobile/services/order-customers/customer_order_service.dart';
import 'package:sarti_mobile/views/customer/customer_orders_details.dart';
import 'package:sarti_mobile/views/customer/review_product_costumer.dart';

class CustomerOrdersList extends StatelessWidget {
  static const name = 'customer-orders-list';
  CustomerOrdersList({Key? key}) : super(key: key);
  final CustomerOrderService customerOrderService = CustomerOrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: FutureBuilder<List<OrderDelivery>>(
              future: customerOrderService.getOrders('', '', ''), // Fetch orders from the service
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay pedidos disponibles.'));
                }
                final orders = snapshot.data!;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _buildOrderCard(context, order);
                  },
                );
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
          /*
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
          */
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
            /*
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
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderDelivery order) {
    final statusColor = order.status == 'Pendiente' ? Colors.red : Colors.green;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        //show basical info from orders and the products
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Pedido #${order.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  order.orderDeliveryStep ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Fecha: ${order.createdAt}'),
            //customer and address
            const SizedBox(height: 8),
            Text('Cliente: ${order.sartiOrder?.customer?.name}'),
            const SizedBox(height: 8),
            Text('Dirección: ${order.address?.locality} ${order.address?.street} ${order.address?.externalNumber}'),
            const SizedBox(height: 8),
            Text('Total: \$${order.sartiOrder?.total.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Productos:'),
            const SizedBox(height: 8),
            for (final product in order.sartiOrder?.productOrders ?? [])
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.product?.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${product.amount}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //amount
                  Text(
                    ' x \$${product.product?.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  //total final
                  Text(
                    ' == \$${(product.total).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            const SizedBox(height: 8),
          ],

        ),
      ),
    );
  }
}
