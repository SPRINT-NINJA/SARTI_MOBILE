import 'package:flutter/material.dart';
import 'email_login_screen.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de inicio como visitante
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
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
              'assets/logo/ICON-SARTI.png',
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
