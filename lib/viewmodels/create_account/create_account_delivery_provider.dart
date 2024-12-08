import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/email.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';
import 'package:sarti_mobile/models/inputs/lastname.dart';
import 'package:sarti_mobile/models/inputs/password.dart';

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

  onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(name: name, isValid: _validateForm(state));
  }

  onSurnameChanged(String value) {
    final surname = Name.dirty(value);
    state = state.copyWith(surname: surname, isValid: _validateForm(state));
  }

  onLastNameChanged(String value) {
    final lastName = Lastname.dirty(value);
    state = state.copyWith(lastName: lastName, isValid: _validateForm(state));
  }

  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email, isValid: _validateForm(state));
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(password: password, isValid: _validateForm(state));
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword = Password.dirty(value);
    state = state.copyWith(
        confirmPassword: confirmPassword, isValid: _validateForm(state));
  }

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
    final confirmPassword = Password.dirty(state.confirmPassword.value);

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
  final Name name;
  final Name surname;
  final Lastname lastName;
  final Email email;
  final Password password;
  final Password confirmPassword;
  final List<bool> steps;
  final int currentStep;

  const CreateAccountDeliveryState({
    this.surname = const Name.pure(),
    this.lastName = const Lastname.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.steps = const [false, false, false],
    this.currentStep = 0,
  });

  CreateAccountDeliveryState copyWith({
    FormStatus? formStatus,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Name? surname,
    Lastname? lastName,
    Email? email,
    Password? password,
    Password? confirmPassword,
    List<bool>? steps,
    int currentStep = 0,
  }) {
    return CreateAccountDeliveryState(
      formStatus: formStatus ?? this.formStatus,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      steps: steps ?? this.steps,
      currentStep: currentStep,
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
      steps: $steps,
      currentStep: $currentStep,
 
    )''';
  }
}
