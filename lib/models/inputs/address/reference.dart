import 'package:formz/formz.dart';

// Define input validation errors
enum ReferenceError { empty, minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Reference extends FormzInput<String, ReferenceError> {

  static final referenceRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9.,:\-()\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Reference.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Reference.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ReferenceError.format) return 'Solo se aceptan números';
    if (displayError == ReferenceError.minLength) return 'El campo debe tener al menos 20 caracteres';
    if (displayError == ReferenceError.maxLength) return 'El campo no puede tener más de 100 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ReferenceError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ReferenceError.empty;
    if (!referenceRegExp.hasMatch(value)) return ReferenceError.format;
    if (value.length < 20) return ReferenceError.minLength;
    if (value.length > 100) return ReferenceError.maxLength;
    return null;
  }
}