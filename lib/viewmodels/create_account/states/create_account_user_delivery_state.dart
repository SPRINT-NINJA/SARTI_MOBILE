import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';

class CreateAccountUserDeliveryState {
  final FormStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final int currentStep;
  final bool isLoading;
  final bool isSaving;
  // section personal
  final bool isFormPersonalValid;
  final bool isFormPersonalPosted;
  final Name name;
  final Name surname;
  final Lastname lastName;

  // section credentials
  final bool isFormCredentialsValid; //validate submit
  final bool isFormCredentialsPosted; // validate errors

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  const CreateAccountUserDeliveryState({
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
    this.currentStep = 0,
    this.isLoading = false,
    this.isSaving = false,
    // section personal
    this.isFormPersonalPosted = false,
    this.isFormPersonalValid = false,
    this.name = const Name.pure(),
    this.surname = const Name.pure(),
    this.lastName = const Lastname.pure(),

    // section credentials
    this.isFormCredentialsPosted = false,
    this.isFormCredentialsValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  CreateAccountUserDeliveryState copyWith({
    FormStatus? formStatus,
    bool? isFormPosted,
    bool? isValid,
    int? currentStep,
    bool? isLoading,
    bool? isSaving,
    //
    bool? isFormPersonalValid,
    bool? isFormPersonalPosted,
    Name? name,
    Name? surname,
    Lastname? lastName,
    //
    bool? isFormCredentialsValid,
    bool? isFormCredentialsPosted,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) {
    return CreateAccountUserDeliveryState(
      formStatus: formStatus ?? this.formStatus,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      //
      isFormPersonalValid: isFormPersonalValid ?? this.isFormPersonalValid,
      isFormPersonalPosted: isFormPersonalPosted ?? this.isFormPersonalPosted,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lastName: lastName ?? this.lastName,
      //
      isFormCredentialsValid:
      isFormCredentialsValid ?? this.isFormCredentialsValid,
      isFormCredentialsPosted:
      isFormCredentialsPosted ?? this.isFormCredentialsPosted,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  String toString() {
    return '''CreateAccountDeliveryState(
      formStatus: $formStatus,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      name: $name,
      surname: $surname,
      lastName: $lastName,
      email: $email,
      password: $password,
      confirmPassword: $confirmPassword,
    )''';
  }
}
