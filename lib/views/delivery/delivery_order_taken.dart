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
                          Image.asset('assets/delivery/peding_delivery.png', height: 50),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pedido #${_takedOrders[index].orderNumber}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text('Calle: ${_takedOrders[index].address.street}', style: TextStyle(color: Colors.grey[600])),
                                Text('Número: ${_takedOrders[index].address.externalNumber}', style: TextStyle(color: Colors.grey[600])),
                                Text('Colonia: ${_takedOrders[index].address.colony}', style: TextStyle(color: Colors.grey[600])),
                                Text('Municipio: ${_takedOrders[index].address.city}', style: TextStyle(color: Colors.grey[600])),
                                Text('Estado: ${_takedOrders[index].address.state}', style: TextStyle(color: Colors.grey[600])),
                                Text('Código Postal: ${_takedOrders[index].address.zipCode}', style: TextStyle(color: Colors.grey[600])),
                                Text('Referencia: ${_takedOrders[index].address.referenceNear}', style: TextStyle(color: Colors.grey[600])),
                                Text('ToTAL: \$${_takedOrders[index].sartiOrder.total}', style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AcceptOrderModal(),
                            );
                          },
                          child: Text('Aceptar pedido'),
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
