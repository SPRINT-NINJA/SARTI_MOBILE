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
    return
      ListView.builder(
      itemCount: _takedOrders.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //image from url on order
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pedido #${_takedOrders[index].orderNumber}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Estado: ${_takedOrders[index].orderDeliveryStep}'),
                          Text('Cliente: ${_takedOrders[index].sartiOrder?.customer?.name} ${_takedOrders[index].sartiOrder?.customer?.firstLastName}'),
                          Text('Dirección: ${_takedOrders[index].address?.street} ${_takedOrders[index].address?.externalNumber} ${_takedOrders[index].address?.colony}' ?? ''),
                          Text('Total: \$${_takedOrders[index].sartiOrder?.total}'),

                          //show the products on orders.sartiOrder.productsOrder.products
                          const SizedBox(height: 8),
                          Text(
                            "Productos:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _takedOrders[index].sartiOrder?.productOrders?.length ?? 0,
                            itemBuilder: (context, productIndex) {
                              final product = _takedOrders[index].sartiOrder?.productOrders?[productIndex];

                              return Card(
                                child: ListTile(
                                  leading: Image.network(
                                    product?.product?.mainImage ?? '',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.broken_image, size: 50); // Placeholder on error
                                    },
                                  ),
                                  title: Text(product?.product?.name ?? 'Producto desconocido'),
                                  subtitle: Text('Precio: \$${product?.product?.price ?? 0}'),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('Cantidad: ${product?.amount ?? 0}'),
                                      Text('Total: \$${product?.total ?? 0}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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