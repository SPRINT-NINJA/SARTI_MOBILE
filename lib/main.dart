import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarti_mobile/test/config/theme/app_theme.dart';
import 'package:sarti_mobile/test/presentation/screens/chat/chat_screen.dart';
import 'package:sarti_mobile/test/providers/chat_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Yes or no',
          theme: AppTheme(selectedColor: 5).theme(),
          home: const ChatScreen()),
    );
  }
}
