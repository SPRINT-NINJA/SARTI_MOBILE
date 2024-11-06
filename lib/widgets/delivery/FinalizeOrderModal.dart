import 'package:flutter/material.dart';
import 'package:sarti_mobile/widgets/delivery/OrderCompletedSuccessfullyModal.dart';
import 'package:sarti_mobile/utils/colors.dart';

class FinalizeOrderModal extends StatelessWidget{
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
              'Finalizar Pedido',
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
              '¿Estas seguro de finalizar el pedido?',
              style: TextStyle(
                color: Colors.grey[600], 
                fontSize: 15
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.sencudaryColor,
                        textStyle: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('Cancelar'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) => OrderCompletedSuccessfully(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        textStyle: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('Finalizar'),
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
