import 'package:formz/formz.dart';

// Define input validation errors
enum StreetError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Street extends FormzInput<String, StreetError> {

  static final streetRegExp = RegExp(r'^(?!.*\s{2})[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Street.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Street.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == StreetError.empty) return 'El campo no puede estar vacío';
    if (displayError == StreetError.format) return 'No se aceptan caracteres especiales';
    if (displayError == StreetError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == StreetError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StreetError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return StreetError.empty;
    if (!streetRegExp.hasMatch(value)) return StreetError.format;
    if (value.length < 4) return StreetError.minLength;
    if (value.length > 45) return StreetError.maxLength;
    return null;
  }
}