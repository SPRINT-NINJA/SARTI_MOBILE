import 'package:formz/formz.dart';

// Define input validation errors
enum InternalNumberError { length, maxLength, format, isPositive }

// Extend FormzInput and provide the input type and error type.
class InternalNumber extends FormzInput<String, InternalNumberError> {

  static final internalNumberRegExp = RegExp(r'^[0-9]+$');
  // Call super.pure to represent an unmodified form input.
  const InternalNumber.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const InternalNumber.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == InternalNumberError.format) return 'Solo se aceptan números';
    if (displayError == InternalNumberError.maxLength) return 'El campo no puede tener más de 3 caracteres';
    if (displayError == InternalNumberError.isPositive) return 'El campo debe ser un número positivo';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  InternalNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return null;
    if (!internalNumberRegExp.hasMatch(value)) return InternalNumberError.format;
    if (int.tryParse(value) == null) return InternalNumberError.isPositive;
    if (value.length > 3) return InternalNumberError.maxLength;
    return null;
  }
}