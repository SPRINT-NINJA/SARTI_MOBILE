part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, submitting, submitted }

class RegisterFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Name name;

  const RegisterFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.name = const Name.pure(),
  });

  RegisterFormState copyWith({FormStatus? formStatus,
    bool? isValid,
    Name? name}) =>
      RegisterFormState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        name: name ?? this.name,
      );

  @override
  List<Object> get props => [formStatus, isValid, name];
}
