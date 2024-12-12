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
    return AlertDialog(
      title: const Text('Aceptar Pedido',),
      content: const Text('¿Estas seguro de aceptar el pedido?'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(false); // Return false for "No"
          },
          child: Text('No'),
        ),
        TextButton(
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
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al aceptar el pedido'),
                    backgroundColor: Colors.red,
                  )
              );
            }
            Navigator.of(context).pop(true); // Return true for "Yes"
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
