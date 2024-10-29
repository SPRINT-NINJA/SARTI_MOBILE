import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/validate_email_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ValidateEmailView()
    );
  }
}