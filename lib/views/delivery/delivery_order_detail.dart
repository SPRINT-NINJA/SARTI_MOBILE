import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';
import 'package:sarti_mobile/widgets/delivery/FinalizeOrderModal.dart';

class DeliveryOrderDetail extends StatelessWidget {
  final bool pedidoActivo;

  DeliveryOrderDetail({this.pedidoActivo = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pedidoActivo ? _PedidoDetailView(context) : _NoPedidoView(),
    );
  }

  Widget _PedidoDetailView(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Detalles de Pedido",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo/ICON_SARTI.png',
                          height: 100,
                          alignment: Alignment.center,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tarro de barro de 10cm',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      "Detalles de la Entrega",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Comprador: Juan Pérez',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Domicilio: Calle Ejemplo #123,\nCol. Centro, Municipio,\nMor., C.P. 62000',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => FinalizeOrderModal(),
                          );
                        },
                        child: Text('Finalizar Pedido'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primaryColor,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _NoPedidoView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Image.asset('assets/delivery/awaiting_delivery.png', height: 200),
          SizedBox(height: 20),
          Text(
            'No tienes ningún pedido activo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
