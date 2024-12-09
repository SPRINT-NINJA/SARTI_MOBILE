import 'package:formz/formz.dart';

// Define input validation errors
enum ExternalNumberCodeError { empty , maxLength, format, isPositive }

// Extend FormzInput and provide the input type and error type.
class ExternalNumberCode extends FormzInput<String, ExternalNumberCodeError> {

  static final externalNumberCodeRegExp = RegExp(r'^[0-9]+$');
  // Call super.pure to represent an unmodified form input.
  const ExternalNumberCode.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ExternalNumberCode.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ExternalNumberCodeError.empty) return 'El campo no puede estar vacío';
    if (displayError == ExternalNumberCodeError.format) return 'Solo se aceptan números';
    if (displayError == ExternalNumberCodeError.maxLength) return 'El campo no puede tener más de 3 caracteres';
    if (displayError == ExternalNumberCodeError.isPositive) return 'El campo debe ser un número positivo';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ExternalNumberCodeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ExternalNumberCodeError.empty;
    if (!externalNumberCodeRegExp.hasMatch(value)) return ExternalNumberCodeError.format;
    if (int.tryParse(value) == null) return ExternalNumberCodeError.isPositive;
    if (value.length > 3) return ExternalNumberCodeError.maxLength;
    return null;
  }
}