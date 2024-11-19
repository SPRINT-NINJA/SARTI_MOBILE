import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';

class SellersListView extends StatelessWidget {
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
      body: _SellersList(),
    );
  }

  Widget _SellersList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Emprendedores",
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
            itemCount: 6, // Número de vendedores
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logo/ICON-SARTI.png',
                        height: 100,
                        alignment: Alignment.center,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tienda Oficial ALPA ✅',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '¡Dale un toque único a tu fiesta! Pintamos y elaboramos cerámica personalizada para que cada detalle sea especial.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Acción al presionar el botón
                              },
                              child: Text('Ver productos de ALPA'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.sencudaryColor,
                                foregroundColor: Colors.white,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
}
