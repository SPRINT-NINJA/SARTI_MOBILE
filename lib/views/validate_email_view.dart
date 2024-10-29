import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/recovery_password_view.dart';

class ValidateEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingresa tu correo electrónico para el cambio de contraseña',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de recuperación de contraseña
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoveryPasswordView()),
                );
              },
              child: Text('Continuar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
