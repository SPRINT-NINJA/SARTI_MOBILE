import 'package:formz/formz.dart';

// Define input validation errors
enum ExternalNumberError { empty , maxLength, format, isPositive }

// Extend FormzInput and provide the input type and error type.
class ExternalNumber extends FormzInput<String, ExternalNumberError> {

  static final externalNumberRegExp = RegExp(r'^[0-9]+$');
  // Call super.pure to represent an unmodified form input.
  const ExternalNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ExternalNumber.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ExternalNumberError.empty) return 'El campo no puede estar vacío';
    if (displayError == ExternalNumberError.format) return 'Solo se aceptan números';
    if (displayError == ExternalNumberError.maxLength) return 'El campo no puede tener más de 3 caracteres';
    if (displayError == ExternalNumberError.isPositive) return 'El campo debe ser un número positivo';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ExternalNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ExternalNumberError.empty;
    if (!externalNumberRegExp.hasMatch(value)) return ExternalNumberError.format;
    if (int.tryParse(value) == null) return ExternalNumberError.isPositive;
    if (value.length > 3) return ExternalNumberError.maxLength;
    return null;
  }
}