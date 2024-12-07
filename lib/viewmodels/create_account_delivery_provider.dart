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
class CreateAccountDeliveryNotifier extends StateNotifier<CreateAccountDeliveryState> {
  CreateAccountDeliveryNotifier(): super(const CreateAccountDeliveryState());

  onNameChanged(String value) {
    final name = Name.dirty(value);
    state = state.copyWith(name: name, isValid: Formz.validate([name]));
  }

  onSubmitted() {
    _touchEveryField();
    if (!state.isValid) return;

    print('Submitted $state');
  }

  _touchEveryField() {
    final name = Name.dirty(state.name.value);

    state = state.copyWith(
      name: name,
      isValid: Formz.validate([state.name]),
      isFormPosted: true,
    );
  }
}

// state of provider
class CreateAccountDeliveryState {
  final FormStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final Name name;

  const CreateAccountDeliveryState({
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
  });

  CreateAccountDeliveryState copyWith({
    FormStatus? formStatus,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
  }) {
    return CreateAccountDeliveryState(
      formStatus: formStatus ?? this.formStatus,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '''CreateAccountDeliveryProvider(
      formStatus: $formStatus,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      name: $name,
    )''';
  }
}
