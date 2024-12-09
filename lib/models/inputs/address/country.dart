import 'package:formz/formz.dart';

// Define input validation errors
enum CountryError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Country extends FormzInput<String, CountryError> {

  static final countryRegExp = RegExp(r'^(?!.*\s{2})[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Country.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Country.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == CountryError.empty) return 'El campo no puede estar vacío';
    if (displayError == CountryError.format) return 'No se aceptan caracteres especiales';
    if (displayError == CountryError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == CountryError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CountryError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CountryError.empty;
    if (!countryRegExp.hasMatch(value)) return CountryError.format;
    if (value.length < 4) return CountryError.minLength;
    if (value.length > 45) return CountryError.maxLength;
    return null;
  }
}