import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';
import 'package:sarti_mobile/models/user_customer.dart';
import 'package:sarti_mobile/services/services.dart';
import 'package:sarti_mobile/viewmodels/create_account/states/create_account_user_costumer_state.dart';

///state provider
final createAccountCustomerProvider = StateNotifierProvider.autoDispose<
    CreateAccountCustomerNotifier, CreateAccountUserCostumerState>((ref) {
  final deliveryService = ref.watch(authServiceProvider).createUserCostumer;
  return CreateAccountCustomerNotifier(deliveryService);
});

// implementation of notifier
class CreateAccountCustomerNotifier
    extends StateNotifier<CreateAccountUserCostumerState> {
  final Future<String> Function(Map<String, dynamic> userCustomerLike)?
      onSubmitCallback;

  CreateAccountCustomerNotifier(this.onSubmitCallback)
      : super(const CreateAccountUserCostumerState()) {
    state = state.copyWith(
      totalSteps: 2,
      isStepPosted: List.filled(3, false),
      isStepValid: List.filled(3, false),
      currentStep: 0,
    );
  }

  Future<String> createUserCustomer(UserCustomer user) async {
    if (state.isLoading) return 'Loading';
    if (onSubmitCallback == null) return 'Error';

    state = state.copyWith(isLoading: true);

    final userCustomerLike = {
      "email": user.email,
      "password": user.password,
      "name": user.name,
      "firstLastName": user.firstLastName,
      "secondLastName": user.secondLastName,
    };

    try {
      final userCustomer = await onSubmitCallback!(userCustomerLike);
      state =
          state.copyWith(isLoading: false, formStatus: FormStatus.submitted);

      print('UserCustomer: $userCustomer');
      return userCustomer;
    } catch (e) {
      return 'Error';
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  bool isStepValid(int index) {
    if (state.currentStep == 1) {
      return Formz.validate([
        state.name,
        state.surname,
        state.lastName,
      ]);
    } else if (state.currentStep == 2) {
      return Formz.validate([
        state.email,
        state.password,
        state.confirmPassword,
      ]);
    } else if (state.currentStep == 3) {
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
    }
    return false;
  }

  // section personal
  onNameChanged(String value) {
    final name = Name.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([name]);
    state = state.copyWith(
      name: name,
      isStepValid: isStepValid,
    );
  }

  onSurnameChanged(String value) {
    final surname = Name.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([surname]);
    state = state.copyWith(
      surname: surname,
      isStepValid: isStepValid,
    );
  }

  onLastNameChanged(String value) {
    final lastName = Lastname.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([lastName]);
    state = state.copyWith(
      lastName: lastName,
      isStepValid: isStepValid,
    );
  }

  // section credentials
  onEmailChanged(String value) {
    final email = Email.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([email]);
    state = state.copyWith(
      email: email,
      isStepValid: isStepValid,
    );
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([password]);
    state = state.copyWith(
      password: password,
      isStepValid: isStepValid,
    );
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([confirmPassword]);
    state = state.copyWith(
      confirmPassword: confirmPassword,
      isStepValid: isStepValid,
    );
  }

  // section address
  onCountryChanged(String value) {
    final country = Country.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([country]);
    state = state.copyWith(
      country: country,
      isStepValid: isStepValid,
    );
  }

  onStateChanged(String value) {
    final stateAddress = State.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([stateAddress]);
    state = state.copyWith(
      state: stateAddress,
      isStepValid: isStepValid,
    );
  }

  onCityChanged(String value) {
    final city = City.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([city]);
    state = state.copyWith(
      city: city,
      isStepValid: isStepValid,
    );
  }

  onLocalityChanged(String value) {
    final locality = Locality.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([locality]);
    state = state.copyWith(
      locality: locality,
      isStepValid: isStepValid,
    );
  }

  onColonyChanged(String value) {
    final colony = Colony.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([colony]);
    state = state.copyWith(
      colony: colony,
      isStepValid: isStepValid,
    );
  }

  onStreetChanged(String value) {
    final street = Street.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([street]);
    state = state.copyWith(
      street: street,
      isStepValid: isStepValid,
    );
  }

  onZipCodeChanged(String value) {
    final zipCode = ZipCode.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([zipCode]);
    state = state.copyWith(
      zipCode: zipCode,
      isStepValid: isStepValid,
    );
  }

  onExternalNumberChanged(String value) {
    final externalNumber = ExternalNumber.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([externalNumber]);
    state = state.copyWith(
      externalNumber: externalNumber,
      isStepValid: isStepValid,
    );
  }

  onInternalNumberChanged(String value) {
    final internalNumber = InternalNumber.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([internalNumber]);
    state = state.copyWith(
      internalNumber: internalNumber,
      isStepValid: isStepValid,
    );
  }

  onReferenceChanged(String value) {
    final reference = Reference.dirty(value);
    final isStepValid = state.isStepValid;
    isStepValid[state.currentStep] = Formz.validate([reference]);
    state = state.copyWith(
      reference: reference,
      isStepValid: isStepValid,
    );
  }

  onSubmittedForm() {
    if (state.currentStep == 0) {
      final isValid = _onValidatePersonalData();
      if (isValid) goToNextStep();
    }else if (state.currentStep == 1) {
      final isValid = _onValidateCredentials();
      if (isValid) goToNextStep();
    }
  }

  bool _onValidatePersonalData() {
    final name = Name.dirty(state.name.value);
    final surname = Name.dirty(state.surname.value);
    final lastName = Lastname.dirty(state.lastName.value);
    final isStepValid = state.isStepValid;

    final isStepPosted = state.isStepPosted;
    isStepPosted[0] = true;

    isStepValid[0] = Formz.validate([name, surname, lastName]);
    state = state.copyWith(
      name: name,
      surname: surname,
      lastName: lastName,
      isStepValid: isStepValid,
      isStepPosted: isStepPosted,
    );
    return isStepValid[0];
  }

  bool _onValidateCredentials() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: state.confirmPassword.value,
    );
    final isStepValid = state.isStepValid;
    final isStepPosted = state.isStepPosted;

    isStepPosted[1] = true;
    isStepValid[1] = Formz.validate([email, password, confirmPassword]);

    state = state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isStepValid: isStepValid,
      isStepPosted: isStepPosted,
    );
    return isStepValid[1];
  }

  onCurrentStepChanged(int value) {
    state = state.copyWith(currentStep: value);
  }

  void goToNextStep() {
    if (state.currentStep < state.totalSteps - 1) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void goToPreviousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }
}
