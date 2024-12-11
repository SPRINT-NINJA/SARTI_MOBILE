import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/customer/review_product_costumer.dart';
import 'package:sarti_mobile/widgets/custom_navbar.dart';

class CustomerOrdersDetails extends StatelessWidget {
  final Map<String, dynamic> purchaseData;

  CustomerOrdersDetails({required this.purchaseData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(title: 'Detalle de la Compra'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      purchaseData['date'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Image.asset(
                      purchaseData['imagePath'],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      purchaseData['productName'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              buildDetailRow('Producto:', purchaseData['productName']),
              buildDetailRow('Precio:', '\$${purchaseData['price']}'),
              buildDetailRow('Total:', '\$${purchaseData['total']}'),
              buildDetailRow('Número de orden:', '${purchaseData['orderNumber']}'),
              buildDetailRow('Tipo de entrega:', purchaseData['deliveryType']),
              buildDetailRow('Cantidad de unidades:', '${purchaseData['quantity']}'),
              buildDetailRow('Estado:', purchaseData['status']),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(248, 151, 50, 1), 
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                      ),
                    ),
                    onPressed: () {
                      // Acción de volver a comprar
                      print('Volver a comprar');
                    },
                    child: const Text('Volver a comprar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(248, 151, 50, 1), 
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewProductoCustomer(),
                        ),
                      );
                    },
                    child: const Text('Crear reseña'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
