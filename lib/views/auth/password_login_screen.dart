import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/router/app_router.dart';
import 'package:sarti_mobile/views/auth/home_screen.dart';
import 'validate_email_view.dart';
import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/views/auth/validate_email_view.dart';

class PasswordLoginScreen extends StatefulWidget {
  final String userEmail;

  PasswordLoginScreen({super.key, required this.userEmail});

  @override
  _PasswordLoginScreenState createState() => _PasswordLoginScreenState();
}

class _PasswordLoginScreenState extends State<PasswordLoginScreen> {
  final AuthService _authService = AuthService();
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
                  /*CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/user_profile.png'),
                    radius: 20,
                  ),*/
                  SizedBox(width: 10),
                  Text(
                    widget.userEmail,
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
                    textStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () async {
                    final email = widget.userEmail;
                    final password = passwordController.text;

                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("La contraseña es obligatoria."),
                        ),
                      );
                      return;
                    }

                    try {
                      final response = await _authService.login(email, password);
                      if (response['error'] != true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Inicio de sesión exitoso')),
                        );
                        context.pushNamed(HomeScreen.name);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  response['message'] ?? 'Error al iniciar sesión.')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al iniciar sesión.')),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ValidateEmailView(),
                  ),
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
