import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/router/app_router.dart';
import 'package:sarti_mobile/config/theme/colors.dart';
import 'package:sarti_mobile/services/auth_service.dart';
import 'package:sarti_mobile/views/auth/create_account/create_account_customer_form_view.dart';
import 'package:sarti_mobile/views/auth/email_login_screen.dart';

class RecoveryPasswordView extends StatelessWidget {
  final String userEmail;

  const RecoveryPasswordView({super.key, required this.userEmail});
  static final AuthService _authService = AuthService();
  static final TextEditingController codeController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

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
              controller: codeController,
              decoration: InputDecoration(
                labelText: 'Código de verificación',
                border: UnderlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Nueva contraseña',
                border: UnderlineInputBorder(),
              ),
              obscureText: true, // Oculta la contraseña
            ),
            SizedBox(height: 40.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    var error =  await _authService.recoveryPassword(userEmail, codeController.text, passwordController.text);
                    if (!error) {
                      GoRouter.of(context).go('/');
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                        content: Text('Error al cambiar la contraseña'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text('Cambiar contraseña'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
