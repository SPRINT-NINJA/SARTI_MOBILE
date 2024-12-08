import 'package:flutter/material.dart';
import 'password_login_screen.dart';
import 'package:sarti_mobile/config/theme/colors.dart';

class EmailLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Ingresa el correo electrónico',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 80),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordLoginScreen(
                              userEmail: emailController.text),
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
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Acción para crear cuenta
              },
              child: Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
