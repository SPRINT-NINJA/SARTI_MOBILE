import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';

class OrderCompletedSuccessfully extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/delivery/successful_delivery.png', height: 200),
            SizedBox(height: 20),
            Text(
              'Pedido finalizado con éxito',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el modal
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }
}
