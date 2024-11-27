import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/app_theme.dart';
import 'package:sarti_mobile/views/auth/create_account_customer_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).theme(),
      home: const CreateAccountCustomerView(),
    );
  }
}
