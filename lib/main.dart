import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/delivery/delivery_orders_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: DeliveryOrdersList(),
    );
  }
}
