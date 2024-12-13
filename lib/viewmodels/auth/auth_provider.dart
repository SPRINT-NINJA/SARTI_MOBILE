import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/config/storage/key_value_storage.dart';
import 'package:sarti_mobile/models/user.dart';
import 'package:sarti_mobile/services/user_delivery_service.dart';
import 'package:sarti_mobile/viewmodels/auth/create_account/states/create_account_user_seller_state.dart';
import 'package:sarti_mobile/viewmodels/auth/create_account/states/steps_form.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';
import 'package:sarti_mobile/viewmodels/auth_errors.dart';

part 'auth_provider.g.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final loadingProvider = StateProvider<bool>((ref) => false);

@riverpod
class StepsFormSeller extends _$StepsFormSeller {
  @override
  StepsForm build() {
    const int steps = 4;

    return StepsForm(
      currentStep: 0,
      totalSteps: steps - 1,
      controller: PageController(),
      isStepPosted: List.filled(steps, false),
      isStepValid: List.filled(steps, false),
      isLoading: false,
      isSaved: false,
    );
  }

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
  CreateAccountUserSellerState build() => const CreateAccountUserSellerState();

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
          state.name,
          state.surname,
          state.lastName,
        ]);
      case 1:
        final businessName = BusinessName.dirty(state.businessName.value);
        final description = BusinessDescription.dirty(state.description.value);
        final wallet = Wallet.dirty(state.wallet.value);

        state = state.copyWith(
          businessName: businessName,
          description: description,
          wallet: wallet,
        );

        return Formz.validate([
          state.businessName,
          state.description,
          state.wallet,
        ]);

      case 2:
        final email = Email.dirty(state.email.value);
        final password = Password.dirty(state.password.value);
        final confirmPassword = ConfirmPassword.dirty(
          password: state.password.value,
          value: state.confirmPassword.value,
        );

        state = state.copyWith(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        );

        return Formz.validate([
          state.email,
          state.password,
          state.confirmPassword,
        ]);
      case 3:
        final country = Country.dirty(state.country.value);
        final stateAddress = StateAddress.dirty(state.state.value);
        final city = City.dirty(state.city.value);
        final locality = Locality.dirty(state.locality.value);
        final colony = Colony.dirty(state.colony.value);
        final street = Street.dirty(state.street.value);
        final zipCode = ZipCode.dirty(state.zipCode.value);
        final externalNumber = ExternalNumber.dirty(state.externalNumber.value);
        final internalNumber = InternalNumber.dirty(state.internalNumber.value);
        final reference = Reference.dirty(state.reference.value);

        state = state.copyWith(
          country: country,
          state: stateAddress,
          city: city,
          locality: locality,
          colony: colony,
          street: street,
          zipCode: zipCode,
          externalNumber: externalNumber,
          internalNumber: internalNumber,
          reference: reference,
        );

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
Future<bool> createUserSeller(CreateUserSellerRef ref) async {
  final user = ref.watch(userSellerStateProvider);
  final payload = {
    "email": user.email.value,
    "password": user.password.value,
    "name": user.name.value,
    "firstLastName": user.surname.value,
    "secondLastName": user.lastName.value,
    "profilePicture": "string",
    "frontIdentification": "string",
    "backIdentification": "string",
    "bussinessName": user.businessName.value,
    "description": user.description.value,
    "wallet": user.wallet.value,
    "address": {
      "country": user.country.value,
      "state": user.state.value,
      "city": user.city.value,
      "locality": user.locality.value,
      "colony": user.colony.value,
      "street": user.street.value,
      "zipCode": user.zipCode.value,
      "externalNumber": user.externalNumber.value,
      "internalNumber": user.internalNumber.value,
      "referenceNear": user.reference.value,
      "addressType": addressTypeToString(user.addressType),
    }
  };
  final authService = ref.read(authServiceProvider);
  final isSaves = await authService.createUserSeller(payload);
  return isSaves != 'Error';
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final keyValueStorageService = KeyValueStorage();
  return AuthNotifier(
      authService: authService, keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;
  final KeyValueStorage keyValueStorageService;

  AuthNotifier(
      {required this.authService, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

/*  Future<void> loginUser( String email, String password ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authService.login(email, password);
      _setLoggedUser( user );

    } on CustomError catch (e) {
      logout( e.message );
    } catch (e){
      logout( 'Error no controlado' );
    }

    // final user = await authRepository.login(email, password);
    // state =state.copyWith(user: user, authStatus: AuthStatus.authenticated)

  }*/

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.read<String>('token');
    if (token == null) return logout();

    try {
      final user =
          await authService.getUserByEmail('joelherreraxd10@gmial.com');
      if (user == null) return logout();
      //check if there user
      setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void setLoggedUser(User user) async {
    await keyValueStorageService.write('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }


  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.delete('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
