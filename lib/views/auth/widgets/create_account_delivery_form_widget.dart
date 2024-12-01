import 'package:flutter/material.dart';
import 'package:sarti_mobile/config/constant/environment.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';

class CreateAccountDeliveryFormWidget extends StatelessWidget {
  const   CreateAccountDeliveryFormWidget({
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
          const Text(
            'Crea tu cuenta de repartidor',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
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
                    labelText: 'Foto de rostro',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText:
                    'Foto de identificación oficial parte frontal (INE, pasaporte, licencia)',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText:
                    'Foto de identificación oficial parte trasera (INE, pasaporte, licencia)',
                  ),
                ),
                const SizedBox(height: 50),
                ButtonFill(
                    theme: theme,
                    textButton: 'Continuar',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/create-account-business-2');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
