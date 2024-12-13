import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/orders/delivery_orders_model.dart';
import 'package:sarti_mobile/views/customer/review_product_costumer.dart';
import 'package:sarti_mobile/widgets/custom_navbar.dart';

class CustomerOrdersDetails extends StatelessWidget {
  final OrderDelivery purchaseData;

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
                      purchaseData.orderNumber.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

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
