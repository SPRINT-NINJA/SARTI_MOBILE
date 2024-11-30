import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/app_theme.dart';
import 'package:sarti_mobile/config/router/app_router.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).theme(),
    );
  }
}
