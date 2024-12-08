import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';

enum FormStatus { invalid, valid, validating, submitting, submitted, posting }

///state provider
final createAccountDeliveryProvider = StateNotifierProvider.autoDispose<
    CreateAccountDeliveryNotifier, CreateAccountDeliveryState>((ref) {
  return CreateAccountDeliveryNotifier();
});

// implementation of notifier
class CreateAccountDeliveryNotifier
    extends StateNotifier<CreateAccountDeliveryState> {
  CreateAccountDeliveryNotifier() : super(const CreateAccountDeliveryState());

  // section personal
  onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      isFormPersonalValid: _validateFormPersonal(state),
    );
  }

  onSurnameChanged(String value) {
    final surname = Name.dirty(value);
    state = state.copyWith(
      surname: surname,
      isFormPersonalValid: _validateFormPersonal(state),
    );
  }

  onLastNameChanged(String value) {
    final lastName = Lastname.dirty(value);
    state = state.copyWith(
      lastName: lastName,
      isFormPersonalValid: _validateFormPersonal(state),
    );
  }

  onSubmittedInformationPersonal() {
    print("onSubmittedInformationPersonal");
    // touch every field
    final name = Name.dirty(state.name.value);
    final surname = Name.dirty(state.surname.value);
    final lastName = Lastname.dirty(state.lastName.value);

    state = state.copyWith(
      name: name,
      surname: surname,
      lastName: lastName,
      isFormPersonalPosted: true,
      isFormPersonalValid: _validateFormPersonal(state),
    );

    // validate form
    if (!_validateFormPersonal(state)) return;
    print('Submitted Personal${
        'name: ${state.name.value},'
        ' surname: ${state.surname.value},'
        ' lastName: ${state.lastName.value}'}');
  }

  bool _validateFormPersonal(CreateAccountDeliveryState state) {
    return Formz.validate([
      state.name,
      state.surname,
      state.lastName,
    ]);
  }

  // section credentials
  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isFormCredentialsValid: _validateForm(state),
    );
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
      password: password,
      isFormCredentialsValid: _validateForm(state),
    );
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
      confirmPassword: confirmPassword,
      isFormCredentialsValid: _validateForm(state),
    );
  }

  onIsFormCredentialsPostedChanged(bool value) {
    state = state.copyWith(isFormCredentialsPosted: value);
  }

  onSubmittedCredentials() {
    // touch every field
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: state.confirmPassword.value,
      value: state.confirmPassword.value,
    );

    state = state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isFormCredentialsValid: _validateFormCredentials(state),
      isFormCredentialsPosted: true,
    );

    // validate form
    if (!state.isFormCredentialsValid) return;
    print('Submitted credentils$state');
  }

  bool _validateFormCredentials(CreateAccountDeliveryState state) {
    return Formz.validate([
          state.email,
          state.password,
          state.confirmPassword,
        ]) &&
        state.password.value == state.confirmPassword.value;
  }

  // control state
  onIsFormPostedChanged(bool value) {
    state = state.copyWith(isFormPosted: value);
  }

  onCurrentStepChanged(int value) {
    state = state.copyWith(currentStep: value);
  }

  onValidStep(int index) {
    final name = Name.dirty(state.name.value);
    final surname = Name.dirty(state.surname.value);
    final lastName = Lastname.dirty(state.lastName.value);

    final steps = List<bool>.from(state.steps);
    steps[index] = Formz.validate([
      state.name,
      state.surname,
      state.lastName,
    ]);
    state = state.copyWith(
      name: name,
      surname: surname,
      lastName: lastName,
      steps: steps,
      isFormPosted: true,
    );
  }

  onSubmitted() {
    _touchEveryField();
    if (!state.isValid) return;

    print('Submitted $state');
  }

  _touchEveryField() {
    final name = Name.dirty(state.name.value);
    final surname = Name.dirty(state.surname.value);
    final lastName = Lastname.dirty(state.lastName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
        password: state.confirmPassword.value,
        value: state.confirmPassword.value);

    state = state.copyWith(
      name: name,
      surname: surname,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: _validateForm(state),
      isFormPosted: true,
    );
  }

  bool _validateForm(CreateAccountDeliveryState state) {
    return Formz.validate([
          state.name,
          state.surname,
          state.lastName,
          state.email,
          state.password,
          state.confirmPassword,
        ]) &&
        state.password.value == state.confirmPassword.value;
  }
}

// state of provider
class CreateAccountDeliveryState {
  final FormStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final List<bool> steps;
  final int currentStep;

  // section personal
  final bool isFormPersonalValid;
  final bool isFormPersonalPosted;
  final Name name;
  final Name surname;
  final Lastname lastName;

  // section credentials
  final bool isFormCredentialsValid; //validate submmit
  final bool isFormCredentialsPosted; // validate errors

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  const CreateAccountDeliveryState({
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
    this.steps = const [false, false, false],
    this.currentStep = 0,

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

  CreateAccountDeliveryState copyWith({
    FormStatus? formStatus,
    bool? isFormPosted,
    bool? isValid,
    List<bool>? steps,
    int? currentStep,
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
    return CreateAccountDeliveryState(
      formStatus: formStatus ?? this.formStatus,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      steps: steps ?? this.steps,
      currentStep: currentStep ?? this.currentStep,
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
