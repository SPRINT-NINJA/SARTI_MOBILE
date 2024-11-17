import 'package:flutter/material.dart';
import 'package:sarti_mobile/utils/colors.dart';
import 'package:sarti_mobile/views/auth/validate_email_view.dart';

class PasswordLoginScreen extends StatefulWidget {
  final String userEmail;

  PasswordLoginScreen({required this.userEmail});

  @override
  _PasswordLoginScreenState createState() => _PasswordLoginScreenState();
}

class _PasswordLoginScreenState extends State<PasswordLoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true; // Controla la visibilidad de la contraseña

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
              'Ingresa tu contraseña de SARTI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/user_profile.png'),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'usuario',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Cambia la visibilidad
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 40), // Espacio antes del botón
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 120, // Ancho del botón
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    // Lógica para continuar con la autenticación
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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ValidateEmailView()),
                );
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
