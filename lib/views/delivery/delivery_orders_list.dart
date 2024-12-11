import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/widgets/delivery/AcceptOrderModal.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_detail.dart';
// import 'package:sarti_mobile/screens/delivery_profile.dart'; // Import de la pantalla de perfil

class DeliveryOrdersList extends StatefulWidget {
  @override
  _DeliveryOrdersListState createState() => _DeliveryOrdersListState();
}

class _DeliveryOrdersListState extends State<DeliveryOrdersList> {
  int _selectedIndex = 0;
  bool hasPedidos = true; // Cambiar a false para ver la otra vista

  // View para navegacion
  final List<Widget> _screens = [
    DeliveryOrdersList(), // Vista 'Inicio'
    DeliveryOrderDetail(), // Vista 'Pedido'
    // Perfil(), // Vista 'Perfil' (agregar cuando esté lista)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Pedido'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
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
            itemCount: 4, // Número de pedidos
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
                          Image.asset('assets/logo/ICON-SARTI.png', height: 100),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tarro de barro de 10cm',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text('Calle:', style: TextStyle(color: Colors.grey[600])),
                                Text('Número:', style: TextStyle(color: Colors.grey[600])),
                                Text('Colonia:', style: TextStyle(color: Colors.grey[600])),
                                Text('Municipio:', style: TextStyle(color: Colors.grey[600])),
                                Text('Estado:', style: TextStyle(color: Colors.grey[600])),
                                Text('\$150', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
