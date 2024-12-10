import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/theme/colors.dart';

class AcceptOrderModal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Aceptar Pedido',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.error_outline, color: 
              AppColors.primaryColor,
              size: 100,
            ),
            SizedBox(height: 16),
            Text(
              '¿Estas seguro de aceptar el pedido?',
              style: TextStyle(
                color: Colors.grey[600], 
                fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.sencudaryColor,
                      textStyle: TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    child: Text('Cancelar'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        textStyle: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      child: Text('Aceptar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
