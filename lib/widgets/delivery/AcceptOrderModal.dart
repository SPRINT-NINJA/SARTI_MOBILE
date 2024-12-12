import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/router/app_router.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/services/delivery/delivery_orders_service.dart';
import 'package:sarti_mobile/views/delivery/delivery_order_taken.dart';

class AcceptOrderModal extends StatelessWidget{
  final DeliveryOrdersService _deliveryOrdersService = DeliveryOrdersService();
  final int orderId;

  AcceptOrderModal({required this.orderId});


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
                      onPressed: () async {
                        var response = await _deliveryOrdersService.acceptOrder(orderId.toString());

                        if(response){
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pedido aceptado'),
                              backgroundColor: AppColors.primaryColor,
                            )
                          );
                          //nav to taken orders
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DeliveryOrderTaken(),
                            )
                          );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al aceptar el pedido'),
                              backgroundColor: Colors.red,
                            )
                          );
                        }
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
