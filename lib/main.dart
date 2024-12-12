import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/views/auth/home_screen.dart';
import 'package:sarti_mobile/views/auth/product_list_screen.dart';
import 'package:sarti_mobile/views/auth/top_rated.dart';


Future<void> main() async {

  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).theme(),
      home: HomeScreen()
    );
  }
}