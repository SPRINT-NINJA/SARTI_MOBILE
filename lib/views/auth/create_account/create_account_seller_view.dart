import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/viewmodels/create_account/create_account_seller_provider.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';

import '../../../widgets/auth/custom_text_form_field.dart';

class CreateAccountSellerView extends ConsumerWidget {
  const CreateAccountSellerView({super.key});

  static const String nameView = 'create-account-seller-view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerStepsForm = ref.watch(stepsFormSellerProvider);
    final userSellerState = ref.watch(userSellerStateProvider);

    Widget buildBottomNavigationBar() {
      return BottomNavigationBar(
        currentIndex: providerStepsForm.currentStep,
        onTap: (index) {
          providerStepsForm.controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 1),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Información personal"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: "Datos finacieros"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_rounded), label: "Direcciónes"),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: PageView(
        controller: providerStepsForm.controller,
        onPageChanged:
            ref.read(stepsFormSellerProvider.notifier).onCurrentStepChanged,
        children: [
          const _SectionPersonalData(),
          const _SectionBusinessData(),
          Container(
            color: randomColor(),
            child: const Text('Step 2'),
          ),
          Container(
            color: randomColor(),
            child: const Text('Step 3'),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

class _SectionPersonalData extends ConsumerWidget {
  const _SectionPersonalData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userSellerStateProvider);
    final notifier = ref.read(userSellerStateProvider.notifier);
    final formSteps = ref.watch(stepsFormSellerProvider);
    final isSectionStepPosted = formSteps.isStepPosted[formSteps.currentStep];

    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Icon(
              Icons.person,
              color: theme.primaryColor,
              size: 100,
            ),
            const SizedBox(width: 10),
            const Text(
              'Crea tu cuenta de cliente',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Form(
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Nombre(s)',
                    onChanged: notifier.onNameChanged,
                    errorMsg: isSectionStepPosted ? state.name.errMsg : null,
                    initialValue: state.name.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Primer apellido',
                    onChanged: notifier.onSurnameChanged,
                    errorMsg: isSectionStepPosted ? state.surname.errMsg : null,
                    initialValue: state.surname.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: RichText(
                        text: const TextSpan(
                      text: 'Segundo apellido',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: ' (opcional)',
                            style: TextStyle(color: Colors.grey))
                      ],
                    )),
                    onChanged: notifier.onLastNameChanged,
                    errorMsg:
                        isSectionStepPosted ? state.lastName.errMsg : null,
                    initialValue: state.lastName.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        final userState =
                            ref.read(userSellerStateProvider.notifier);
                        final stepsForm = ref.read(stepsFormSellerProvider);
                        final isFormValid =
                            userState.isFormValid(stepsForm.currentStep);

                        //set posted and valid
                        final listStepPosted = stepsForm.isStepPosted;
                        listStepPosted[stepsForm.currentStep] = true;

                        final listStepValid = stepsForm.isStepValid;
                        listStepValid[stepsForm.currentStep] = isFormValid;

                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .onIsStepPostedChanged(listStepPosted);
                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .onIsStepValidChanged(listStepValid);

                        if (isFormValid) {
                          ref
                              .read(stepsFormSellerProvider.notifier)
                              .goToNextStep();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario incompleto'),
                          ),
                        );
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionBusinessData extends ConsumerWidget {
  const _SectionBusinessData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userSellerStateProvider);
    final notifier = ref.read(userSellerStateProvider.notifier);
    final formSteps = ref.watch(stepsFormSellerProvider);
    final isSectionStepPosted = formSteps.isStepPosted[formSteps.currentStep];

    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Icon(
              Icons.person,
              color: theme.primaryColor,
              size: 100,
            ),
            const SizedBox(width: 10),
            const Text(
              'Ingresa los datos de tu negocio',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.yellow[100],
              child: Row(
                children: [
                  Tooltip(
                    message: 'Usa el correo de PayPal para recibir pagos.',
                    child: Icon(Icons.info, color: Colors.yellow[900]),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Correo electrónico asociado a PayPal',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Form(
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Correo PayPal',
                    onChanged: notifier.onWalletChanged,
                    errorMsg: isSectionStepPosted ? state.name.errMsg : null,
                    initialValue: state.name.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Nombre de tu negocio',
                    onChanged: notifier.onBusinessNameChanged,
                    errorMsg: isSectionStepPosted ? state.surname.errMsg : null,
                    initialValue: state.surname.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: RichText(
                        text: const TextSpan(
                      text: 'Segundo apellido',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: ' (opcional)',
                            style: TextStyle(color: Colors.grey))
                      ],
                    )),
                    onChanged: notifier.onLastNameChanged,
                    errorMsg:
                        isSectionStepPosted ? state.lastName.errMsg : null,
                    initialValue: state.lastName.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        final userState =
                            ref.read(userSellerStateProvider.notifier);
                        final stepsForm = ref.read(stepsFormSellerProvider);
                        final isFormValid =
                            userState.isFormValid(stepsForm.currentStep);

                        //set posted and valid
                        final listStepPosted = stepsForm.isStepPosted;
                        listStepPosted[stepsForm.currentStep] = true;

                        final listStepValid = stepsForm.isStepValid;
                        listStepValid[stepsForm.currentStep] = isFormValid;

                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .onIsStepPostedChanged(listStepPosted);
                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .onIsStepValidChanged(listStepValid);

                        if (isFormValid) {
                          ref
                              .read(stepsFormSellerProvider.notifier)
                              .goToNextStep();
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario incompleto'),
                          ),
                        );
                      }),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref.read(stepsFormSellerProvider.notifier).goToPreviousStep();
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Regresar'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
