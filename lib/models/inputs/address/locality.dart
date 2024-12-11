import 'package:formz/formz.dart';

// Define input validation errors
enum LocalityError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Locality extends FormzInput<String, LocalityError> {

  static final localityRegExp = RegExp(r'^(?!.*\s{2})[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Locality.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Locality.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == LocalityError.empty) return 'El campo no puede estar vacío';
    if (displayError == LocalityError.format) return 'No se aceptan caracteres especiales';
    if (displayError == LocalityError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == LocalityError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  LocalityError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return LocalityError.empty;
    if (!localityRegExp.hasMatch(value)) return LocalityError.format;
    if (value.length < 4) return LocalityError.minLength;
    if (value.length > 45) return LocalityError.maxLength;
    return null;
  }
}