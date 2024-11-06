import 'package:flutter/material.dart';
import 'email_login_screen.dart';
import 'package:sarti_mobile/utils/colors.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(
                'Continuar como visitante ',
                style: TextStyle(
                  color: AppColors.sencudaryColor,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/logo/ICON_SARTI.png',
              height: 200,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // Navegar a la pantalla de ingreso de correo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLoginScreen()),
                );
              },
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {},
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
