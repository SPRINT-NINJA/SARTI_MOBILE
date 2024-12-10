import 'package:flutter/material.dart';
import 'password_login_screen.dart';
import 'validate_email_view.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sarti_mobile/config/theme/colors.dart';

class EmailLoginScreen extends StatelessWidget {
  static const name = 'email-login';
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: UnderlineInputBorder(),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "El correo es obligatorio."),
                  EmailValidator(
                      errorText: "Por favor ingresa un correo válido."),
                ]),
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
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordLoginScreen(
                              userEmail: emailController.text,
                            ),
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
      ),
    );
  }
}
