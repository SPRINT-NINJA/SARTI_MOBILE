import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:sarti_mobile/services/delivery/delivery_orders_service.dart';

class DeliveryOrderHistorial extends StatefulWidget {
  static const name = 'delivery-order-historial';

  @override
  _DeliveryOrderHistorialState createState() => _DeliveryOrderHistorialState();
}

class _DeliveryOrderHistorialState extends State<DeliveryOrderHistorial> {
  bool hasPedidos = true; // Update this dynamically based on orders
  final DeliveryOrdersService _deliveryOrdersService = DeliveryOrdersService();
  List<OrderDelivery> _takedOrders = []; // Store fetched orders
  bool _isLoading = true; // Loading state
  String? _errorMessage; // Error message

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final takenOrders = await _deliveryOrdersService.getHistorialOrders();
      setState(() {
        _takedOrders = takenOrders ?? []; // Replace 'data' with the correct key
        hasPedidos = _takedOrders.isNotEmpty;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching orders: $error';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasPedidos ? _OrdersList() : _EmptyOrder(),
    );
  }

  Widget _OrdersList() {
    return ListView.builder(
      itemCount: _takedOrders.length,
      itemBuilder: (context, index) {
        final order = _takedOrders[index];
        return ListTile(
          title: Text(order.orderNumber),
          subtitle: Text(order.status as String),
          onTap: () {
            Navigator.pushNamed(context, '/delivery/order-detail', arguments: order.id);
          },
        );
      },
    );
  }

  Widget _EmptyOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Image.asset('assets/delivery/peding_delivery.png', height: 200),
          SizedBox(height: 20),
          Text(
            'No hay pedidos en historial',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

}