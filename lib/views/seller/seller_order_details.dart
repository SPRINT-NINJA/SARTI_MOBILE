import 'package:flutter/material.dart';

class PurchaseDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Espacio extra en la parte superior
              SizedBox(height: 48),
              // Título en la parte superior de la pantalla
              Center(
                child: Column(
                  children: [
                    Text(
                      'Detalle de la Compra',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '15 de octubre',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Imagen del producto
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo/ICON_SARTI.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Paquete de Cake-Topper con Cupcakes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Detalles del producto
              Text(
                'Producto: Paquete de Cake-Topper con Cupcake',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Precio: \$250',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Total: \$250',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Número de orden: 15',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Tipo de entrega: Envío',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Cantidad de unidades: 1',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text(
                    'Estado: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Entregado',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 8),
              // Detalles del pago
              Text(
                '\$250',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Visa Débito ****1123',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '13 de octubre',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Pago aprobado',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción para volver a compras
                    },
                    child: Text('Volver a comprar'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para crear reseña
                    },
                    child: Text('Crear Reseña'),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
