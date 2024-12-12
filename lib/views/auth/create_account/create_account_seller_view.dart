import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/views/auth/email_login_screen.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';
import 'package:sarti_mobile/widgets/auth/password_text_form_field.dart';
import 'package:sarti_mobile/widgets/full_screen_loader.dart';

import '../../../viewmodels/auth/auth_provider.dart';
import '../../../widgets/auth/custom_text_form_field.dart';

class CreateAccountSellerView extends ConsumerWidget {
  const CreateAccountSellerView({super.key});

  static const String nameView = 'create-account-seller-view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerStepsForm = ref.watch(stepsFormSellerProvider);
    ref.watch(userSellerStateProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Crear cuenta'),
          ),
          body: PageView(
            controller: providerStepsForm.controller,
            onPageChanged:
                ref.read(stepsFormSellerProvider.notifier).onCurrentStepChanged,
            children: const [
              _SectionPersonalData(),
              _SectionBusinessData(),
              _SectionCredentialsUser(),
              _SectionAddressData(),
            ],
          ),
        ),
        if (ref.watch(loadingProvider)) const FullScreenLoader(),
      ],
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
              'Crea tu cuenta de emprendedor',
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
                          return;
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
              Icons.business,
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
                    errorMsg: isSectionStepPosted ? state.wallet.errMsg : null,
                    initialValue: state.wallet.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Nombre de tu negocio',
                    onChanged: notifier.onBusinessNameChanged,
                    errorMsg:
                        isSectionStepPosted ? state.businessName.errMsg : null,
                    initialValue: state.businessName.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Descripción de tu negocio',
                    onChanged: notifier.onDescriptionChanged,
                    errorMsg:
                        isSectionStepPosted ? state.description.errMsg : null,
                    initialValue: state.description.value,
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
                          return;
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
                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .goToPreviousStep();
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

class _SectionCredentialsUser extends ConsumerWidget {
  const _SectionCredentialsUser({super.key});

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
              Icons.account_circle,
              color: theme.primaryColor,
              size: 100,
            ),
            const SizedBox(width: 10),
            const Text(
              'Ingresa tus credenciales',
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
                    label: 'Email',
                    onChanged: notifier.onEmailChanged,
                    errorMsg: isSectionStepPosted ? state.email.errMsg : null,
                    initialValue: state.email.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Password',
                    onChanged: notifier.onPasswordChanged,
                    errorMsg:
                        isSectionStepPosted ? state.password.errMsg : null,
                    initialValue: state.password.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Confirmar Contraseña',
                    onChanged: notifier.onConfirmPasswordChanged,
                    errorMsg: isSectionStepPosted
                        ? state.confirmPassword.errMsg
                        : null,
                    initialValue: state.confirmPassword.value,
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
                          return;
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
                        ref
                            .read(stepsFormSellerProvider.notifier)
                            .goToPreviousStep();
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

class _SectionAddressData extends ConsumerWidget {
  const _SectionAddressData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userSellerStateProvider);
    final notifier = ref.read(userSellerStateProvider.notifier);
    final formSteps = ref.watch(stepsFormSellerProvider);
    final isSectionStepPosted = formSteps.isStepPosted[formSteps.currentStep];

    final ScrollController scrollController = ScrollController();
    final ValueNotifier<bool> isAtBottom = ValueNotifier(false);

    scrollController.addListener(() {
      isAtBottom.value =
          scrollController.offset >= scrollController.position.maxScrollExtent;
    });

    final theme = Theme.of(context);

    Future<void> submit() async {
      final stepsForm = ref.read(stepsFormSellerProvider);
      final isFormValid = notifier.isFormValid(stepsForm.currentStep);

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

      if (!isFormValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formulario incompleto'),
          ),
        );
        return;
      }

      ref.read(loadingProvider.notifier).state = true;

      try {
        final result = await ref.read(createUserSellerProvider.future);

        ref.read(loadingProvider.notifier).state = false;


        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(result
                    ? 'Cuenta registrada'
                    : 'Error al registrar la cuenta'),
                content: Text(result
                    ? 'Tu cuenta ha sido registrada con éxito'
                    : 'Ocurrió un error al registrar tu cuenta'),
              );
            },
          );

          // redirect to login timer
          Timer(const Duration(seconds: 3), () {
            context.goNamed(EmailLoginScreen.name);
          });
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
        return;
      } finally {
        ref.read(loadingProvider.notifier).state = false;
      }
    }

    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: isAtBottom,
        builder: (context, atBottom, _) {
          return FloatingActionButton(
            onPressed: () {
              if (atBottom) {
                scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Icon(atBottom ? Icons.arrow_upward : Icons.arrow_downward),
          );
        },
      ),
      body: ListView(
        controller: scrollController,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                Icon(
                  Icons.location_on,
                  color: theme.primaryColor,
                  size: 100,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Ingresa la dirección de tu negocio',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'País',
                        onChanged: notifier.onCountryChanged,
                        errorMsg:
                            isSectionStepPosted ? state.country.errMsg : null,
                        initialValue: state.country.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Estado',
                        onChanged: notifier.onStateChanged,
                        errorMsg:
                            isSectionStepPosted ? state.state.errMsg : null,
                        initialValue: state.state.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Ciudad',
                        onChanged: notifier.onCityChanged,
                        errorMsg:
                            isSectionStepPosted ? state.city.errMsg : null,
                        initialValue: state.city.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Localidad',
                        onChanged: notifier.onLocalityChanged,
                        errorMsg:
                            isSectionStepPosted ? state.locality.errMsg : null,
                        initialValue: state.locality.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Colonia',
                        onChanged: notifier.onColonyChanged,
                        errorMsg:
                            isSectionStepPosted ? state.colony.errMsg : null,
                        initialValue: state.colony.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Calle',
                        onChanged: notifier.onStreetChanged,
                        errorMsg:
                            isSectionStepPosted ? state.street.errMsg : null,
                        initialValue: state.street.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Código Postal',
                        onChanged: notifier.onZipCodeChanged,
                        errorMsg:
                            isSectionStepPosted ? state.zipCode.errMsg : null,
                        initialValue: state.zipCode.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: RichText(
                            text: const TextSpan(
                          text: 'Número Interior',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: ' (opcional)',
                                style: TextStyle(color: Colors.grey))
                          ],
                        )),
                        onChanged: notifier.onInternalNumberChanged,
                        errorMsg: isSectionStepPosted
                            ? state.internalNumber.errMsg
                            : null,
                        initialValue: state.internalNumber.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Número Exterior',
                        onChanged: notifier.onExternalNumberChanged,
                        errorMsg: isSectionStepPosted
                            ? state.externalNumber.errMsg
                            : null,
                        initialValue: state.externalNumber.value,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'Referencias',
                        onChanged: notifier.onReferenceChanged,
                        errorMsg:
                            isSectionStepPosted ? state.reference.errMsg : null,
                        initialValue: state.reference.value,
                      ),
                      const SizedBox(height: 40),
                      ButtonFill(
                          theme: theme,
                          textButton: ref.watch(loadingProvider)
                              ? 'Registrando...'
                              : 'Registrar',
                          onPressed: () {
                            submit();
                          }),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ref
                                .read(stepsFormSellerProvider.notifier)
                                .goToPreviousStep();
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Regresar'),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
