import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/viewmodels/auth/create_account/create_account_costumer_provider.dart';
import 'package:sarti_mobile/viewmodels/auth/create_account/states/create_account_user_costumer_state.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';
import 'package:sarti_mobile/widgets/auth/custom_text_form_field.dart';
import 'package:sarti_mobile/widgets/auth/password_text_form_field.dart';
import 'package:sarti_mobile/widgets/full_screen_loader.dart';


class CreateAccountCustomerFormView extends ConsumerWidget {
  static const name = 'create_account_customer';

  const CreateAccountCustomerFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController();

    final state = ref.watch(createAccountCustomerProvider);
    final notifier = ref.read(createAccountCustomerProvider.notifier);

    Future<void> onSubmittedForm(BuildContext context) async {
      notifier.onSubmittedForm().then((_) {
        if (!state.isStepValid[state.currentStep]) return;
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Registro exitoso'),
                content: const Text('Tu cuenta ha sido registrada con éxito'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }

      });
    }

    if (state.isLoading) {
      return const FullScreenLoader();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea tu cuenta de Cliente'),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: notifier.onCurrentStepChanged,
        children: [
          _SectionPersonalData(
            onNext: () => nextStep(controller),
            state: state,
            notifier: notifier,
          ),
          _SectionCredentialsUser(
              onNext: () => nextStep(controller),
              onPrevious: () => previousStep(controller),
              state: state,
              notifier: notifier),
          _SectionAddressUser(
              onNext: () => nextStep(controller),
              onPrevious: () => previousStep(controller),
              state: state,
              notifier: notifier,
              onSubmittedForm: () => onSubmittedForm(context)

          ),
        ],
      ),
    );
  }

  void nextStep(PageController controller) {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousStep(PageController controller) {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class _SectionPersonalData extends ConsumerWidget {
  const _SectionPersonalData(
      {required this.onNext, required this.state, required this.notifier});

  final VoidCallback onNext;
  final CreateAccountUserCostumerState state;
  final CreateAccountCustomerNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentStep = state.currentStep;

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
                    errorMsg: state.isStepPosted[currentStep]
                        ? state.name.errMsg
                        : null,
                    initialValue: state.name.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Primer apellido',
                    onChanged: notifier.onSurnameChanged,
                    errorMsg: state.isStepPosted[currentStep]
                        ? state.surname.errMsg
                        : null,
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
                    errorMsg: state.isStepPosted[currentStep]
                        ? state.lastName.errMsg
                        : null,
                    initialValue: state.lastName.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        notifier.onSubmittedForm();
                        if (!state.isStepValid[currentStep]) return;
                        onNext();
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

class _SectionCredentialsUser extends ConsumerWidget {
  const _SectionCredentialsUser({
    required this.onNext,
    required this.onPrevious,
    required this.state,
    required this.notifier,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final CreateAccountUserCostumerState state;
  final CreateAccountCustomerNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentStep = state.currentStep;

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
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.email.errMsg
                        : null,
                    initialValue: state.email.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Password',
                    onChanged: notifier.onPasswordChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.password.errMsg
                        : null,
                    initialValue: state.password.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Confirmar Contraseña',
                    onChanged: notifier.onConfirmPasswordChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.confirmPassword.errMsg
                        : null,
                    initialValue: state.confirmPassword.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        notifier.onSubmittedForm();
                        if (!state.isStepValid[currentStep]) return;
                        onNext();
                      }),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        notifier.goToPreviousStep();
                        onPrevious();
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

class _SectionAddressUser extends ConsumerWidget {
  const _SectionAddressUser({
    required this.onNext,
    required this.onPrevious,
    required this.state,
    required this.notifier,
    required this.onSubmittedForm,
  });

  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final CreateAccountUserCostumerState state;
  final CreateAccountCustomerNotifier notifier;
  final Future<void> Function() onSubmittedForm;



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
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
              'Ingresa tu dirección',
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
                    label: 'País',
                    onChanged: notifier.onCountryChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.country.errMsg
                        : null,
                    initialValue: state.country.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Estado',
                    onChanged: notifier.onStateChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.state.errMsg
                        : null,
                    initialValue: state.state.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Ciudad',
                    onChanged: notifier.onCityChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.city.errMsg
                        : null,
                    initialValue: state.city.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Localidad',
                    onChanged: notifier.onLocalityChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.locality.errMsg
                        : null,
                    initialValue: state.locality.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Colonia',
                    onChanged: notifier.onColonyChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.colony.errMsg
                        : null,
                    initialValue: state.colony.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Calle',
                    onChanged: notifier.onStreetChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.street.errMsg
                        : null,
                    initialValue: state.street.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Código Postal',
                    onChanged: notifier.onZipCodeChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.zipCode.errMsg
                        : null,
                    initialValue: state.zipCode.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    labelText: RichText(text: const TextSpan(
                      text: 'Número Interior',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: ' (opcional)',
                            style: TextStyle(color: Colors.grey))
                      ],
                    )),
                    onChanged: notifier.onInternalNumberChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.internalNumber.errMsg
                        : null,
                    initialValue: state.internalNumber.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Número Exterior',
                    onChanged: notifier.onExternalNumberChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.externalNumber.errMsg
                        : null,
                    initialValue: state.externalNumber.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Referencias',
                    onChanged: notifier.onReferenceChanged,
                    errorMsg: state.isStepPosted[state.currentStep]
                        ? state.reference.errMsg
                        : null,
                    initialValue: state.reference.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Registrar',
                      onPressed: () => onSubmittedForm()),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        notifier.goToPreviousStep();
                        onPrevious();
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

