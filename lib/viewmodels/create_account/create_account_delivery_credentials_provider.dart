import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/confirm_password.dart';
import 'package:sarti_mobile/models/inputs/email.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';
import 'package:sarti_mobile/models/inputs/lastname.dart';
import 'package:sarti_mobile/models/inputs/password.dart';

enum FormStatus { invalid, valid, validating, submitting, submitted, posting }

///state provider
final createAccountDeliveryCredentialsProvider = StateNotifierProvider.autoDispose<
    CreateAccountDeliveryCredentialsNotifier, CreateAccountDeliveryCredentialsState>((ref) {
  return CreateAccountDeliveryCredentialsNotifier();
});

// implementation of notifier
class CreateAccountDeliveryCredentialsNotifier
    extends StateNotifier<CreateAccountDeliveryCredentialsState> {
  CreateAccountDeliveryCredentialsNotifier() : super(const CreateAccountDeliveryCredentialsState());

  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(email: email, isValid: _validateForm(state));
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(password: password, isValid: _validateForm(state));
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
        confirmPassword: confirmPassword
        , isValid: _validateForm(state));
  }

  onIsFormPostedChanged(bool value) {
    state = state.copyWith(isFormPosted: value);
  }


  onSubmitted() {
    _touchEveryField();
    if (!state.isValid) return;
    print('Submitted $state');
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(password: state.confirmPassword.value, value: state.confirmPassword.value);

    state = state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: _validateForm(state),
      isFormPosted: true,
    );
  }

  bool validatePassword() {
    return state.password.value == state.confirmPassword.value;
  }

  bool _validateForm(CreateAccountDeliveryCredentialsState state) {
    return Formz.validate([
          state.email,
          state.password,
          state.confirmPassword,
        ]) &&
        state.password.value == state.confirmPassword.value;
  }
}

// state of provider
class CreateAccountDeliveryCredentialsState {
  final FormStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  const CreateAccountDeliveryCredentialsState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
  });

  CreateAccountDeliveryCredentialsState copyWith({
    FormStatus? formStatus,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) {
    return CreateAccountDeliveryCredentialsState(
      formStatus: formStatus ?? this.formStatus,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
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
      email: $email,
      password: $password,
      confirmPassword: $confirmPassword, 
    )''';
  }
}
