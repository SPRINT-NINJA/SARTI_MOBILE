import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/services/delivery/delivery_orders_service.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_historial.dart';
import 'package:sarti_mobile/widgets/delivery/AcceptOrderModal.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_detail.dart';

import '../auth/welcome_view.dart';
// import 'package:sarti_mobile/screens/delivery_profile.dart'; // Import de la pantalla de perfil

class DeliveryOrderTaken extends StatefulWidget {
  static const name = 'delivery-orders-list';

  @override
  _DeliveryOrderTakenState createState() => _DeliveryOrderTakenState();
}

class _DeliveryOrderTakenState extends State<DeliveryOrderTaken> {
  int _selectedIndex = 0;
  bool hasPedidos = true; // Update this dynamically based on orders
  final AuthService _authService = AuthService();
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
      final takenOrders = await _deliveryOrdersService.getTakedOrders();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasPedidos ? _OrdersList() : _PendingOrder(),
    );
  }

  Widget _OrdersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Pedidos Disponibles",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
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
                                Text('Cliente: ${_takedOrders[index].sartiOrder?.customer?.name} ${_takedOrders[index].sartiOrder?.customer?.firstLastName}'),
                                Text('Dirección: ${_takedOrders[index].address?.street} ${_takedOrders[index].address?.externalNumber} ${_takedOrders[index].address?.colony}' ?? ''),
                                Text('Referencias: ${_takedOrders[index].address?.referenceNear}' ?? ''),
                                Text('Tipo de dirección: ${_takedOrders[index].address?.addressType}' ?? ''),
                                Text('Repartidor: ${_takedOrders[index].deliveryMan?.name} ${_takedOrders[index].deliveryMan?.firstLastName}'),

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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () async {
                            //parse id to string
                            var orderId = _takedOrders[index].id.toString();

                            var step = _takedOrders[index].orderDeliveryStep == 'Enviado' ? 'ENTREGADO' : 'ENVIADO';
                            final result = await _deliveryOrdersService.changeStatusOrder(orderId, step);
                            if (result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Estado del pedido cambiado'),
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              );
                              // Refresh orders
                              _fetchOrders();
                            }else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al cambiar el estado del pedido'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                          },
                          child: Text( _takedOrders[index].orderDeliveryStep == 'Enviado' ? 'Terminar pedido' : 'Comezar entrega'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _PendingOrder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Image.asset('assets/delivery/peding_delivery.png', height: 200),
          SizedBox(height: 20),
          Text(
            'No tienes ningún pedido activo, ve a la sección de "En recolección" para aceptar pedidos',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
