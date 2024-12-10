import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/models.dart';
import 'package:sarti_mobile/services/camera/camera_gallery_service_impl.dart';
import 'package:sarti_mobile/viewmodels/create_account/create_account_costumer_provider.dart';
import 'package:sarti_mobile/viewmodels/create_account/states/create_account_user_costumer_state.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';
import 'package:sarti_mobile/widgets/auth/custom_text_form_field.dart';
import 'package:sarti_mobile/widgets/auth/password_text_form_field.dart';
import 'package:sarti_mobile/widgets/full_screen_loader.dart';

import '../../../viewmodels/create_account/create_account_delivery_images_provider.dart';
import '../../../viewmodels/create_account/create_account_delivery_provider.dart';
import '../../../viewmodels/create_account/states/create_account_user_delivery_state.dart';

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
          _SectionCredentialsUser(onNext: () => nextStep(controller),
              onPrevious
              : () => previousStep(controller),
              state: state,
              notifier: notifier),
          Container(
            color: randomColor(),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar(WidgetRef ref, PageController controller,
      int currentStep) {
    return BottomNavigationBar(
      currentIndex: currentStep,
      onTap: (index) {
        controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: "Información personal"),
        BottomNavigationBarItem(
            icon: Icon(Icons.card_travel_rounded), label: "Credenciales"),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded), label: "Direcciónes"),
      ],
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
                    errorMsg: state.isStepPosted[state.currentStep] ? state
                        .email.errMsg : null,
                    initialValue: state.email.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Password',
                    onChanged: notifier.onPasswordChanged,
                    errorMsg: state.isStepPosted[state.currentStep] ? state
                        .password.errMsg : null,
                    initialValue: state.password.value,
                  ),
                  const SizedBox(height: 20),
                  PasswordTextFormField(
                    label: 'Confirmar Contraseña',
                    onChanged: notifier.onConfirmPasswordChanged,
                    errorMsg: state.isStepPosted[state.currentStep] ? state
                        .confirmPassword.errMsg : null,
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

class _SectionUploadCredentialPhotos extends ConsumerWidget {
  const _SectionUploadCredentialPhotos({
    required this.theme,
    required this.onNext,
    required this.onPrevious,
    required this.images,
    this.frontPhotoPath,
    this.backPhotoPath,
  });

  final ThemeData theme;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final List<String> images;

  final String? frontPhotoPath;
  final String? backPhotoPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createAccountDeliveryProvider);
    final notifier = ref.read(createAccountDeliveryProvider.notifier);

    Future<void> handleImageSelection(BuildContext context,
        Future<String?> Function() imagePicker,
        Function(String) onImageChanged) async {
      final path = await imagePicker();
      if (path != null) {
        onImageChanged(path);
      }
    }

    Future<void> registerAccount(BuildContext context, WidgetRef ref) async {
      final createAccountDeliveryImages =
      ref.watch(createAccountDeliveryImagesProvider);

      ref.watch(createAccountDeliveryImagesProvider.notifier).onSubmitted();

      if (!createAccountDeliveryImages.isValid) return;

      final UserDelivery user = UserDelivery(
        email: state.email.value,
        password: state.password.value,
        name: state.name.value,
        firstLastName: state.surname.value,
        secondLastName: state.lastName.value,
        profilePicture: createAccountDeliveryImages.imageOfFace.value,
        frontIdentification: createAccountDeliveryImages.imageFrontID.value,
        backIdentification: createAccountDeliveryImages.imageRearID.value,
      );

      final result = await notifier.createUserDelivery(user);
      if (result != 'Error') {
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
      }
    }

    return state.isLoading
        ? const FullScreenLoader()
        : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt,
              color: theme.primaryColor,
              size: 100,
            ),
            RichText(
                text: const TextSpan(children: [
                  TextSpan(
                    text: 'Ingresa tus documentos de identificación oficial ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '(INE, pasaporte, licencia)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ])),
            const SizedBox(height: 30),
            SizedBox(
                height: 200,
                width: double.infinity,
                child: _ImageGallery(
                  images: images,
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                  onPressed: () =>
                      handleImageSelection(
                          context, CameraGalleryServiceImpl().pickImage,
                              (path) {
                            ref
                                .read(createAccountDeliveryImagesProvider
                                .notifier)
                                .onImageFrontIDChanged(path);
                          }),
                  icon: const Icon(Icons.camera_front),
                  label: const Text('Tomar foto frontal')),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                  onPressed: () =>
                      handleImageSelection(
                          context, CameraGalleryServiceImpl().pickImage,
                              (path) {
                            ref
                                .read(createAccountDeliveryImagesProvider
                                .notifier)
                                .onImageRearIDChanged(path);
                          }),
                  icon: const Icon(Icons.camera_rear),
                  label: const Text('Tomar foto trasera')),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                  onPressed: () =>
                      handleImageSelection(
                          context, CameraGalleryServiceImpl().takeSelfie,
                              (path) {
                            ref
                                .read(createAccountDeliveryImagesProvider
                                .notifier)
                                .onImageOfFaceChanged(path);
                          }),
                  icon: const Icon(Icons.person),
                  label: const Text('Foto de rostro')),
            ),
            ref
                .watch(createAccountDeliveryImagesProvider)
                .isFormPosted &&
                !ref
                    .watch(createAccountDeliveryImagesProvider)
                    .isValid
                ? RichText(
                text: TextSpan(
                  text: ref
                      .watch(createAccountDeliveryImagesProvider)
                      .imageOfFace
                      .errMsg ??
                      ref
                          .watch(createAccountDeliveryImagesProvider)
                          .imageFrontID
                          .errMsg ??
                      ref
                          .watch(createAccountDeliveryImagesProvider)
                          .imageRearID
                          .errMsg ??
                      '',
                  style: const TextStyle(color: Colors.red),
                ))
                : const SizedBox(),
            const SizedBox(height: 20),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ButtonFill(
                  onPressed: () => registerAccount(context, ref),
                  theme: theme,
                  textButton: 'Registar cuenta',
                )),
          ],
        ),
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.network(
            'https://placehold.co/250x600.png?text=Credencial+de+elector',
            fit: BoxFit.cover),
      );
    }

    return PageView(
        scrollDirection: Axis.horizontal,
        controller: PageController(
          viewportFraction: 0.8,
        ),
        children: images.map((image) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(image)),
                  placeholder: const NetworkImage(
                    'https://media.tenor.com/pEDQL3XJxdsAAAAi/cat-cute.gif',
                    scale: 0.5,
                  )),
            ),
          );
        }).toList());
  }
}
