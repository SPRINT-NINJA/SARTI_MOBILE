import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/services/delivery/delivery_orders_service.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_historial.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_taken.dart';
import 'package:sarti_mobile/widgets/delivery/AcceptOrderModal.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_detail.dart';

import '../auth/welcome_view.dart';
// import 'package:sarti_mobile/screens/delivery_profile.dart'; // Import de la pantalla de perfil

class DeliveryOrdersList extends StatefulWidget {
  static const name = 'delivery-orders-list';

  @override
  _DeliveryOrdersListState createState() => _DeliveryOrdersListState();
}

class _DeliveryOrdersListState extends State<DeliveryOrdersList> {
  int _selectedIndex = 0;
  bool hasPedidos = true; // Update this dynamically based on orders
  final AuthService _authService = AuthService();
  final DeliveryOrdersService _deliveryOrdersService = DeliveryOrdersService();
  List<OrderDelivery> _orders = []; // Store fetched orders
  List<OrderDelivery> _takedOrders = []; // Store fetched orders
  bool _isLoading = true; // Loading state
  String? _errorMessage; // Error message

  // View para navegacion
  final List<Widget> _screens = [
    DeliveryOrdersList(), // Vista 'Inicio'
    DeliveryOrderTaken(), // Vista 'Pedido'
    DeliveryOrderHistorial(), // Vista 'Historial'
  ];

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
      final orders = await _deliveryOrdersService.getOrders();
      final takenOrders = await _deliveryOrdersService.getTakedOrders();
      setState(() {
        _orders = orders ?? []; // Replace 'data' with the correct key
        _takedOrders = takenOrders ?? []; // Replace 'data' with the correct key
        hasPedidos = _takedOrders.isEmpty;
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
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _authService.logout();
              context.pushNamed(WelcomeView.name);
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo/ICON-SARTI.png',
            width: 24,
            height: 24,
          ),

        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: _selectedIndex == 0 
          ? hasPedidos ? _OrdersList() : _PendingOrder()
          : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'En recolección'),
          BottomNavigationBarItem(icon: Icon(Icons.approval_rounded), label: 'Mis pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Historial de pedidos'),
        ],
      ),
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
            itemCount: _orders.length,
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
                                  'Pedido #${_orders[index].orderNumber}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text('Calle: ${_orders[index].address.street}', style: TextStyle(color: Colors.grey[600])),
                                Text('Número: ${_orders[index].address.externalNumber}', style: TextStyle(color: Colors.grey[600])),
                                Text('Colonia: ${_orders[index].address.colony}', style: TextStyle(color: Colors.grey[600])),
                                Text('Municipio: ${_orders[index].address.city}', style: TextStyle(color: Colors.grey[600])),
                                Text('Estado: ${_orders[index].address.state}', style: TextStyle(color: Colors.grey[600])),
                                Text('Código Postal: ${_orders[index].address.zipCode}', style: TextStyle(color: Colors.grey[600])),
                                Text('Referencia: ${_orders[index].address.referenceNear}', style: TextStyle(color: Colors.grey[600])),
                                Text('ToTAL: \$${_orders[index].sartiOrder.total}', style: TextStyle(color: Colors.grey[600])),
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
            'Tienes un pedido en curso,\ntermínalo para poder tomar otro',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
