import 'package:flutter/material.dart';
import 'package:sarti_mobile/views/auth/login_screen.dart';
import 'package:sarti_mobile/views/auth/recovery_password_view.dart';
import 'package:sarti_mobile/config/theme/colors.dart';

class ValidateEmailView extends StatelessWidget {
  static const name = 'validate-email';

  const ValidateEmailView({super.key});

  static final TextEditingController emailController = TextEditingController();

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
                errorText: _isValidEmail(emailController.text)
                    ? null
                    : 'Por favor ingresa un correo válido',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
            ),
            SizedBox(height: 40.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => _handleContinue(context),
                  child: Text('Continuar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    textStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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

  void _handleContinue(BuildContext context) {
    if (emailController.text.isNotEmpty &&
        _isValidEmail(emailController.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecoveryPasswordView(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            emailController.text.isEmpty
                ? "El correo electrónico es obligatorio."
                : "Por favor ingresa un correo válido.",
          ),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
