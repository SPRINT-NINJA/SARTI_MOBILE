import 'package:flutter/material.dart';

class RecoveryPasswordView extends StatelessWidget {
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
              'Introduce el código de verificación y tu nueva contraseña',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Código de verificación',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nueva contraseña',
                border: UnderlineInputBorder(),
              ),
              obscureText: true, // Oculta la contraseña
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para cambiar la contraseña
              },
              child: Text('Cambiar contraseña'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Color del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}
