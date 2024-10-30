import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/login_screen.dart';
import 'package:sarti_mobile/views/emailLogin_screen.dart';
import 'package:sarti_mobile/views/validate_email_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginScreen(),
    );
  }
}
