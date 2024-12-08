import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sarti_mobile/services/camera/camera_gallery_service_impl.dart';
import 'package:sarti_mobile/viewmodels/create_account/create_account_delivery_credentials_provider.dart';
import 'package:sarti_mobile/widgets/auth/button_fill.dart';
import 'package:sarti_mobile/widgets/auth/custom_text_form_field.dart';

import '../../../viewmodels/create_account/create_account_delivery_images_provider.dart';
import '../../../viewmodels/create_account/create_account_delivery_provider.dart';

class CreateAccountDeliveryView extends ConsumerWidget {
  static const name = 'create_account_delivery';

  const CreateAccountDeliveryView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = PageController();
    final ThemeData theme = Theme.of(context);

    final currentStep = ref.watch(createAccountDeliveryProvider).currentStep;
    final createAccountDeliveryProviderNotifier =
        ref.read(createAccountDeliveryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea tu cuenta de repartidor'),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged:
            createAccountDeliveryProviderNotifier.onCurrentStepChanged,
        children: [
          _SectionPersonalData(
              theme: theme, onNext: () => nextStep(controller)),
          _SectionCredentialsUser(
              theme: theme, onNext: () => nextStep(controller), onPrevious: () => previousStep(controller)),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(ref, controller, currentStep),
    );
  }

  Widget buildBottomNavigationBar(
      WidgetRef ref, PageController controller, int currentStep) {
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
  const _SectionPersonalData({required this.theme, required this.onNext});

  final ThemeData theme;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createAccountDeliveryProviderData =
        ref.watch(createAccountDeliveryProvider);
    final createAccountDeliveryProviderNotifier =
        ref.read(createAccountDeliveryProvider.notifier);

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
              'Crea tu cuenta de repartidor',
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
                    onChanged:
                        createAccountDeliveryProviderNotifier.onNameChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData.name.errMsg
                        : null,
                    initialValue: createAccountDeliveryProviderData.name.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Primer apellido',
                    onChanged:
                        createAccountDeliveryProviderNotifier.onSurnameChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData.surname.errMsg
                        : null,
                    initialValue:
                        createAccountDeliveryProviderData.surname.value,
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
                    onChanged:
                        createAccountDeliveryProviderNotifier.onLastNameChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData.lastName.errMsg
                        : null,
                    initialValue:
                        createAccountDeliveryProviderData.lastName.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        createAccountDeliveryProviderNotifier.onValidStep(0);
                        if (!createAccountDeliveryProviderData.steps[0]) return;
                        createAccountDeliveryProviderNotifier
                            .onIsFormPostedChanged(false);
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
  const _SectionCredentialsUser({required this.theme, required this.onNext, required this.onPrevious});

  final ThemeData theme;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createAccountDeliveryProviderData =
        ref.watch(createAccountDeliveryCredentialsProvider);
    final createAccountDeliveryProviderNotifier =
        ref.read(createAccountDeliveryCredentialsProvider.notifier);

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
                    onChanged:
                        createAccountDeliveryProviderNotifier.onEmailChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData.email.errMsg
                        : null,
                    initialValue: createAccountDeliveryProviderData.email.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Password',
                    onChanged:
                        createAccountDeliveryProviderNotifier.onPasswordChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData.password.errMsg
                        : null,
                    initialValue:
                        createAccountDeliveryProviderData.password.value,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Confirmar Contraseña',
                    onChanged: createAccountDeliveryProviderNotifier
                        .onConfirmPasswordChanged,
                    errorMsg: createAccountDeliveryProviderData.isFormPosted
                        ? createAccountDeliveryProviderData
                            .confirmPassword.errMsg
                        : null,
                    initialValue:
                        createAccountDeliveryProviderData.confirmPassword.value,
                  ),
                  const SizedBox(height: 40),
                  ButtonFill(
                      theme: theme,
                      textButton: 'Continuar',
                      onPressed: () {
                        createAccountDeliveryProviderNotifier.onSubmitted();
                        if (!createAccountDeliveryProviderData.isValid) return;
                        createAccountDeliveryProviderNotifier.onIsFormPostedChanged(false);
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

class _SectionIdentification extends ConsumerWidget {
  const _SectionIdentification({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = theme.primaryColor;

    final providerImage = ref.watch(createAccountDeliveryImagesProvider);

    return Column(
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

        Text(
          'PARTE FRONTAL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontSize: 20,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
            height: 250,
            width: 600,
            child: _ImageGallery(
              image: providerImage.imageFrontID.value ?? '',
            )),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: () async {
                final photoPath = await CameraGalleryServiceImpl().takePhoto();
                if (photoPath == null) return;
                ref
                    .read(createAccountDeliveryImagesProvider.notifier)
                    .onImageFrontIDChanged(photoPath);
                ref
                    .read(createAccountDeliveryProvider.notifier)
                    .onCurrentStepChanged(1);
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tomar foto')),
        ),
        const SizedBox(height: 10),
        const Text(
          'O',
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              onPressed: () async {
                final photoPath =
                    await CameraGalleryServiceImpl().selectPhoto();
                if (photoPath == null) return;
                ref
                    .read(createAccountDeliveryImagesProvider.notifier)
                    .onImageFrontIDChanged(photoPath);
                ref
                    .read(createAccountDeliveryProvider.notifier)
                    .onCurrentStepChanged(1);
              },
              icon: const Icon(Icons.photo_library),
              label: const Text('Abrir galería')),
        ),
        const SizedBox(height: 50),
        providerImage.imageFrontID.errMsg != null
            ? Text(
                providerImage.imageFrontID.errMsg ?? '',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              )
            : const SizedBox(),
        ButtonFill(
            theme: theme,
            textButton:
                providerImage.imageFrontID.isValid ? 'Guardar' : 'Continuar',
            onPressed: () {
              ref
                  .read(createAccountDeliveryImagesProvider.notifier)
                  .onValidateID();
              if (!providerImage.isValidImageID) return;
              ref
                  .read(createAccountDeliveryProvider.notifier)
                  .onCurrentStepChanged(1);
            }),
        const SizedBox(height: 20),
        // back button
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref
                .read(createAccountDeliveryProvider.notifier)
                .onCurrentStepChanged(0);
          },
        ),
      ],
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({
    this.image = '',
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.network(
            'https://placehold.co/250x600.png?text=Credencial+de+elector',
            fit: BoxFit.cover),
      );
    }

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
  }
}

class _SectionPhoto extends StatelessWidget {
  const _SectionPhoto({
    required this.theme,
    this.currentStep = 2,
    required this.controller,
  });

  final int currentStep;
  final PageController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Column(
          children: [
            Icon(
              Icons.camera_alt,
              size: 50,
            ),
            Text(
              'Ingresa tu foto de rostro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 0),
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
                    Navigator.pushNamed(context, '/create-account-business-2');
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionCredentials extends StatelessWidget {
  const _SectionCredentials({
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
          const SizedBox(height: 30),
          _RegisterFormCredentials(theme: theme, controller: controller),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RegisterFormCredentials extends ConsumerWidget {
  const _RegisterFormCredentials({
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final PageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionPersonalData = ref.watch(createAccountDeliveryProvider);
    final sectionPersonalDataProvider =
        ref.read(createAccountDeliveryProvider.notifier);

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Correo Electrónico',
            onChanged: sectionPersonalDataProvider.onEmailChanged,
            errorMsg: sectionPersonalData.isFormPosted
                ? sectionPersonalData.email.errMsg
                : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: sectionPersonalDataProvider.onPasswordChanged,
            errorMsg: sectionPersonalData.isFormPosted
                ? sectionPersonalData.password.errMsg
                : null,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            label: 'Confirmar Contraseña',
            obscureText: true,
            onChanged: sectionPersonalDataProvider.onConfirmPasswordChanged,
            errorMsg: sectionPersonalData.isFormPosted
                ? sectionPersonalData.confirmPassword.errMsg
                : null,
          ),
          const SizedBox(height: 40),
          ButtonFill(
              theme: theme,
              textButton: 'Continuar',
              onPressed: () {
                sectionPersonalDataProvider.onSubmitted();
                if (!sectionPersonalData.isValid) return;

                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
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
    );
  }
}
