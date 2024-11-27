import 'package:flutter/material.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';

class CreateAccountCustomerView extends StatelessWidget {
  const CreateAccountCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Emprededor'),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image.asset(
            'assets/images/logo_sarti_leading.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Crea tu cuenta de repartidor', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ), textAlign: TextAlign.center,  ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Dirección de entrega',
                        ),
                      ),
                      const SizedBox(height: 50),
                      ButtonFill(theme: theme, textButton: 'Continuar', onPressed: () {
                        Navigator.pushNamed(context, '/create-account-business-2');
                      }),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
