import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sarti_mobile/services/user_delivery_service.dart';
import 'package:sarti_mobile/viewmodels/create_account/states/create_account_user_seller_state.dart';
import 'package:sarti_mobile/viewmodels/create_account/states/steps_form.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';

part 'create_account_seller_provider.g.dart';

@riverpod
class StepsFormSeller extends _$StepsFormSeller {
  @override
  StepsForm build() => StepsForm(
        currentStep: 0,
        totalSteps: 2,
        controller: PageController(),
        isStepPosted: List.filled(3, false),
        isStepValid: List.filled(3, false),
        isLoading: false,
        isSaved: false,
      );

  onCurrentStepChanged(int value) {
    state = state.copyWith(currentStep: value);
  }

  onTotalStepsChanged(int value) {
    state = state.copyWith(totalSteps: value);
  }

  onControllerChanged(PageController value) {
    state = state.copyWith(controller: value);
  }

  onIsStepPostedChanged(List<bool> value) {
    state = state.copyWith(isStepPosted: value);
  }

  onIsStepValidChanged(List<bool> value) {
    state = state.copyWith(isStepValid: value);
  }

  onIsLoadingChanged(bool value) {
    state = state.copyWith(isLoading: value);
  }

  onIsSavedChanged(bool value) {
    state = state.copyWith(isSaved: value);
  }


  void goToNextStep() {
    //controller
    state.controller.nextPage(
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void goToPreviousStep() {
    state.controller.previousPage(
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  void dispose() {
    state.controller.dispose();
  }
}

@riverpod
class UserSellerState extends _$UserSellerState {
  @override
  CreateAccountUserSellerState build() =>
      const CreateAccountUserSellerState();

  onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(name: name);
  }

  onSurnameChanged(String value) {
    final surname = Name.dirty(value);
    state = state.copyWith(surname: surname);
  }

  onLastNameChanged(String value) {
    final lastName = Lastname.dirty(value);
    state = state.copyWith(lastName: lastName);
  }

  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email);
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(password: password);
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(confirmPassword: confirmPassword);
  }

  onCountryChanged(String value) {
    final country = Country.dirty(value);
    state = state.copyWith(country: country);
  }

  onStateChanged(String value) {
    final stateAddress = StateAddress.dirty(value);
    state = state.copyWith(state: stateAddress);
  }

  onCityChanged(String value) {
    final city = City.dirty(value);
    state = state.copyWith(city: city);
  }

  onLocalityChanged(String value) {
    final locality = Locality.dirty(value);
    state = state.copyWith(locality: locality);
  }

  onColonyChanged(String value) {
    final colony = Colony.dirty(value);
    state = state.copyWith(colony: colony);
  }

  onStreetChanged(String value) {
    final street = Street.dirty(value);
    state = state.copyWith(street: street);
  }

  onZipCodeChanged(String value) {
    final zipCode = ZipCode.dirty(value);
    state = state.copyWith(zipCode: zipCode);
  }

  onExternalNumberChanged(String value) {
    final externalNumber = ExternalNumber.dirty(value);
    state = state.copyWith(externalNumber: externalNumber);
  }

  onInternalNumberChanged(String value) {
    final internalNumber = InternalNumber.dirty(value);
    state = state.copyWith(internalNumber: internalNumber);
  }

  onReferenceChanged(String value) {
    final reference = Reference.dirty(value);
    state = state.copyWith(reference: reference);
  }

  onBusinessNameChanged(String value) {
    final businessName = BusinessName.dirty(value);
    state = state.copyWith(businessName: businessName);
  }

  onDescriptionChanged(String value) {
    final description = BusinessDescription.dirty(value);
    state = state.copyWith(description: description);
  }

  onWalletChanged(String value) {
    final wallet = Wallet.dirty(value);
    state = state.copyWith(wallet: wallet);
  }

  bool isFormValid(int index) {
    switch (index) {
      case 0:

        final name = Name.dirty(state.name.value);
        final surname = Name.dirty(state.surname.value);
        final lastName = Lastname.dirty(state.lastName.value);

        state = state.copyWith(
          name: name,
          surname: surname,
          lastName: lastName,
        );

        return Formz.validate([
          name,
          surname,
          lastName,
        ]);
      case 1:
        return Formz.validate([
          state.country,
          state.state,
          state.city,
          state.locality,
          state.colony,
          state.street,
          state.zipCode,
          state.externalNumber,
          state.internalNumber,
          state.reference,
        ]);
      case 2:
        return Formz.validate([
          state.businessName,
          state.description,
          state.wallet,
        ]);
      default:
        return false;
    }
  }

}

@riverpod
Future<bool> getUserByEmail(GetUserByEmailRef ref) async {
  await Future.delayed(const Duration(seconds: 2));

  final authService = AuthService();
  final user = await authService.getUserByEmail('crsitian@gmial.com');

  ref.onDispose(() {
    print('Dispose');
  });

  return user != null;
}

@riverpod
Future<String> createUserSeller(CreateUserSellerRef ref) async {
  await Future.delayed(const Duration(seconds: 2));

  /*final isSaves = await AuthService().createUserSeller({
    "email": "B.3KFS3K9RE5mi7XwO-Gg@4b.Act1-H9cV8BTmJCNuLGwqFVgPuQzqMraZ4746gDTV0LshdvUM0p.ppinIwsNTckdpYwnHzYVN2vlEpxyjgR82cb8NN2Hb3BO.Cw",
    "password": "(]_woLhvm*H@Ke8^{tGj0[6U)g|",
    "name": "string",
    "firstLastName": "string",
    "secondLastName": "string",
    "bussinessName": "string",
    "description": "string",
    "wallet": "string",
    "address": {
      "id": 0,
      "country": "string",
      "state": "string",
      "city": "string",
      "locality": "string",
      "colony": "string",
      "street": "string",
      "zipCode": 0,
      "externalNumber": "strin",
      "internalNumber": "strin",
      "referenceNear": "string",
      "addressType": "DOMICILIO"
    }
  });*/

  return 'Success';
}
