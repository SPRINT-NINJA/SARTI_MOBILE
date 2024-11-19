import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/delivery/delivery_orders_list.dart';
import 'package:sarti_mobile/views/auth/product_list_screen.dart';

import 'package:sarti_mobile/views/auth/home_screen.dart';
import 'package:sarti_mobile/views/auth/top_rated.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: ProductosScreen());
  }
}
