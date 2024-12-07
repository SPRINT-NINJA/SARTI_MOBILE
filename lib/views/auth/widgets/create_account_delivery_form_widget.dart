import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';
import 'package:sarti_mobile/widgets/auth/custom_text_form_field.dart';

import '../../../viewmodels/create_account_delivery_provider.dart';

class CreateAccountDeliveryFormWidget extends StatelessWidget {
  const CreateAccountDeliveryFormWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 35, 30, 10),
      child: PageView(
        controller: controller,
        children: [
          _SectionPersonalData(theme: theme, controller: controller),
          _SectionPhoto(theme: theme),
          _SectionIdentification(theme: theme, controller: controller),
        ],
      ),
    );
  }
}
class _SectionPersonalData extends StatelessWidget {
  const _SectionPersonalData({
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 10),
              const Text(
                'Crea tu cuenta de repartidor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _RegisterFormPersonalData(theme: theme, controller: controller),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RegisterFormPersonalData extends ConsumerWidget {
  const _RegisterFormPersonalData({
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final sectionPersonalData = ref.watch(createAccountDeliveryProvider);
    final sectionPersonalDataProvider = ref.read(createAccountDeliveryProvider.notifier);

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre(s)',
            onChanged: sectionPersonalDataProvider.onNameChanged,
            errorMsg: sectionPersonalData.isFormPosted ? sectionPersonalData.name.errMsg : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Teléfono',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
          ),
          const SizedBox(height: 50),
          ButtonFill(
              theme: theme,
              textButton: 'Continuar',
              onPressed: () {
                sectionPersonalDataProvider.onSubmitted();
               /* controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );*/
              }),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 50,
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
            ),
          ),
        ],
      ),
    );
  }
}



class _SectionPhoto extends StatelessWidget {
  const _SectionPhoto({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Crea tu cuenta de repartidor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 35),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Foto de rostro',
                ),
              ),
              const SizedBox(height: 50),
              ButtonFill(
                  theme: theme,
                  textButton: 'Continuar',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/create-account-business-2');
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionIdentification extends StatelessWidget {
  const _SectionIdentification({
    super.key,
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Crea tu cuenta de repartidor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 35),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText:
                      'Foto de identificación oficial parte frontal (INE, pasaporte, licencia)',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText:
                      'Foto de identificación oficial parte trasera (INE, pasaporte, licencia)',
                ),
              ),
              const SizedBox(height: 50),
              ButtonFill(
                  theme: theme,
                  textButton: 'Continuar',
                  onPressed: () {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

