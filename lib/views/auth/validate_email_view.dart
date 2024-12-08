import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/auth/recovery_password_view.dart';
import 'package:sarti_mobile/config/theme/colors.dart';

class ValidateEmailView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

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
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 40.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la vista de recuperación de contraseña
                    if (emailController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecoveryPasswordView(),
                        ),
                      );
                      } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("El correo electrónico es obligatorio."),
                        ),
                      );
                    }
                  },
                  child: Text('Continuar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Regresar al Login',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
