import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';
import 'package:sarti_mobile/models/models.dart';
import 'package:sarti_mobile/services/services.dart';
import 'package:sarti_mobile/viewmodels/create_account/states/create_account_user_delivery_state.dart';


///state provider
final createAccountDeliveryProvider = StateNotifierProvider.autoDispose<CreateAccountDeliveryNotifier, CreateAccountUserDeliveryState>((ref) {
  final deliveryService = ref.watch(userDeliveryServiceProvider);
  return CreateAccountDeliveryNotifier(deliveryService);
});

// implementation of notifier
class CreateAccountDeliveryNotifier extends StateNotifier<CreateAccountUserDeliveryState> {

  final UserDeliveryService deliveryService;

  CreateAccountDeliveryNotifier(this.deliveryService) : super(const CreateAccountUserDeliveryState());

  Future createUserDelivery(UserDelivery user) async {
    if (state.isLoading || !state.isValid) return;

    state = state.copyWith(isLoading: true);

    final userDelivery = await deliveryService.createUserDelivery({
      'name': user.name,
      'surname': user.surname,
      'lastName': user.firstLastName,
      'email': user.email,
      'password': user.password,
    });

    state = state.copyWith(isLoading: false, formStatus: FormStatus.submitted);

    print('UserDelivery: $userDelivery');
  }

  // section personal
  onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(
      name: name,
      isFormPersonalValid: Formz.validate([
        name,
        state.surname,
        state.lastName,
      ]),
    );
  }

  onSurnameChanged(String value) {
    final surname = Name.dirty(value);
    state = state.copyWith(
      surname: surname,
      isFormPersonalValid: Formz.validate([
        surname,
        state.name,
        state.lastName,
      ]),
    );
  }

  onLastNameChanged(String value) {
    final lastName = Lastname.dirty(value);
    state = state.copyWith(
      lastName: lastName,
      isFormPersonalValid: Formz.validate([
        lastName,
        state.name,
        state.surname,
      ]),
    );
  }

  onSubmittedInformationPersonal() {
    print("onSubmittedInformationPersonal");
    // touch every field
    final name = Name.dirty(state.name.value);
    final surname = Name.dirty(state.surname.value);
    final lastName = Lastname.dirty(state.lastName.value);
    final isFormPersonalValid = Formz.validate([
      name,
      surname,
      lastName,
    ]);

    state = state.copyWith(
      name: name,
      surname: surname,
      lastName: lastName,
      isFormPersonalPosted: true,
      isFormPersonalValid: isFormPersonalValid,
    );

    // validate form
    if (!isFormPersonalValid) return;
    print('Submitted Personal${'name: ${state.name.value},'
        ' surname: ${state.surname.value},'
        ' lastName: ${state.lastName.value}'}');
  }

  // section credentials
  onEmailChanged(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isFormCredentialsValid: Formz.validate([
        email,
        state.password,
        state.confirmPassword,
      ]),
    );
  }

  onPasswordChanged(String value) {
    final password = Password.dirty(value);
    state = state.copyWith(
        password: password,
        isFormCredentialsValid: Formz.validate([
          state.email,
          password,
          state.confirmPassword,
        ]));
  }

  onConfirmPasswordChanged(String value) {
    final confirmPassword =
    ConfirmPassword.dirty(password: state.password.value, value: value);
    state = state.copyWith(
        confirmPassword: confirmPassword,
        isFormCredentialsValid: Formz.validate([
          state.email,
          state.password,
          confirmPassword,
        ]));
  }

  onSubmittedCredentials() {
    // touch every field
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
      password: state.password.value,
      value: state.confirmPassword.value,
    );
    final isFormCredentialsValid = Formz.validate([
      state.email,
      state.password,
      state.confirmPassword,
    ]);

    state = state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isFormCredentialsValid: isFormCredentialsValid,
      isFormCredentialsPosted: true,
    );

    // validate form
    if (!isFormCredentialsValid) return;
    print(
      'Submitted credentials${'email: ${state.email.value},'
          ' password: ${state.password.value},'
          ' confirmPassword: ${state.confirmPassword.value}'}',
    );
  }

  // control state
  onIsFormPostedChanged(bool value) {
    state = state.copyWith(isFormPosted: value);
  }

  onCurrentStepChanged(int value) {
    state = state.copyWith(currentStep: value);
  }
}
