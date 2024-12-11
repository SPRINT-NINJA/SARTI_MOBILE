import 'package:flutter/material.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';

class CreateAccountBusinessFormWidget extends StatelessWidget {
  const CreateAccountBusinessFormWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Crea tu cuenta de emprendedor', style: TextStyle(
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
                    labelText: 'Nombre de tu negocio',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descripción de tu negocio',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ubicación de tu negocio',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
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
    );
  }
}