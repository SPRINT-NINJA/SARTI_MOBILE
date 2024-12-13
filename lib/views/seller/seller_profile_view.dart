import 'package:flutter/material.dart';
import 'package:sarti_mobile/models/address.dart';
import 'package:sarti_mobile/models/sellers/user_seller.dart';

class SellerProfileView extends StatelessWidget {
  final UserSeller seller;
  static const name = 'SellerProfileView';

  const SellerProfileView({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil del Vendedor'),
        backgroundColor: Colors.green, // Mantén el color verde
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/images/avatar_placeholder.png'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${seller.name} ${seller.firstLastName} ${seller.secondLastName}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              seller.email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Dirección',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${seller.address.street}, ${seller.address.colony}, ${seller.address.city}, ${seller.address.state}, C.P. ${seller.address.zipCode}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Referencia: ${seller.address.referenceNear}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
