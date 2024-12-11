import 'package:formz/formz.dart';

// Define input validation errors
enum StateError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class StateAddress extends FormzInput<String, StateError> {

  static final stateRegExp = RegExp(r'^(?!.*\s{2})[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  // Call super.pure to represent an unmodified form input.
  const StateAddress.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const StateAddress.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == StateError.empty) return 'El campo no puede estar vacío';
    if (displayError == StateError.format) return 'No se aceptan caracteres especiales';
    if (displayError == StateError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == StateError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StateError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return StateError.empty;
    if (!stateRegExp.hasMatch(value)) return StateError.format;
    if (value.length < 4) return StateError.minLength;
    if (value.length > 45) return StateError.maxLength;
    return null;
  }
}