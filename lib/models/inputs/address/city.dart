import 'package:formz/formz.dart';

// Define input validation errors
enum CityError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class City extends FormzInput<String, CityError> {

  static final cityRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
  // Call super.pure to represent an unmodified form input.
  const City.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const City.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == CityError.empty) return 'El campo no puede estar vacío';
    if (displayError == CityError.format) return 'No se aceptan caracteres especiales';
    if (displayError == CityError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == CityError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CityError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CityError.empty;
    if (!cityRegExp.hasMatch(value)) return CityError.format;
    if (value.length < 4) return CityError.minLength;
    if (value.length > 45) return CityError.maxLength;
    return null;
  }
}