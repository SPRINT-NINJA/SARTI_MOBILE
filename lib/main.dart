import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/viewmodels/auth/auth_provider.dart';

Future<void> main() async {
  await Environment.initEnvironment();
  WidgetsFlutterBinding.ensureInitialized();


  final container = ProviderContainer();
  container.read(authProvider.notifier).checkAuthStatus(); // Verificar la sesión


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).theme(),
    );
  }
}
