import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/constant/enums.dart';
import 'package:sarti_mobile/config/constant/environment.dart';
import 'package:sarti_mobile/views/auth/create_account/create_account.dart';
import 'package:sarti_mobile/views/screens.dart';
import 'package:sarti_mobile/widgets/auth/button_fill_icon.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Bienvenido'),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image.asset(
            'assets/images/logo_sarti_leading.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _LabelInvitedUser(theme: theme),
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo_sarti_leading_fill.png',
                  height: 200,
                ),
                const SizedBox(height: 80),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _StartSessionButton(theme: theme),
                      const SizedBox(height: 20),
                      _CreateAccountButton(theme: theme),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Center(
        child: TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              '¡Crea tu cuenta y forma parte de SARTI ${Environment.API_VERSION}!',
                              style:const  TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ), textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Selecciona el tipo de cuenta que deseas crear',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 34),
                            ButtonFillIcon(theme: theme, textButton: 'Repartidor', onPressed: () {
                            context.pushNamed(CreateAccountDeliveryView.name);
                              // close the modal
                              context.pop();
                            }, icon: Icons.delivery_dining),
                            const SizedBox(height: 34),
                            ButtonFillIcon(theme: theme, textButton: 'Emprendedor', onPressed: () {
                              context.push('/create-account/${ERoles.business}');
                              context.pop();
                            }, icon: Icons.business_center),
                            const SizedBox(height: 34),
                            ButtonFillIcon(theme: theme, textButton: 'Cliente', onPressed: () {
                              context.pushNamed(CreateAccountView.name, pathParameters: {'role': ERoles.costumer.toString()});
                              context.pop();
                            }, icon: Icons.person),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text(
            'Crear cuenta',
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: theme.primaryColor,
              decorationThickness: 2,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      );
    });
  }
}

class _StartSessionButton extends StatelessWidget {
  const _StartSessionButton({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(theme.primaryColor),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/email-login');
        },
        child: const Text(
          'Iniciar sesión con correo',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class _LabelInvitedUser extends StatelessWidget {
  const _LabelInvitedUser({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Continuar como invitado',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor),
        ),
        IconButton(
          color: theme.primaryColor,
          icon: const Icon(Icons.arrow_circle_right_outlined),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],
    );
  }
}
