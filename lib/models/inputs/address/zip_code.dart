import 'package:formz/formz.dart';

// Define input validation errors
enum ZipCodeError { empty , length, maxLength, format, isPositive }

// Extend FormzInput and provide the input type and error type.
class ZipCode extends FormzInput<String, ZipCodeError> {

  static final zipCodeRegExp = RegExp(r'^[0-9]+$');
  // Call super.pure to represent an unmodified form input.
  const ZipCode.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ZipCode.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ZipCodeError.empty) return 'El campo no puede estar vacío';
    if (displayError == ZipCodeError.format) return 'Solo se aceptan números';
    if (displayError == ZipCodeError.maxLength) return 'El campo no puede tener más de 5 caracteres';
    if (displayError == ZipCodeError.isPositive) return 'El campo debe ser un número positivo';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ZipCodeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ZipCodeError.empty;
    if (!zipCodeRegExp.hasMatch(value)) return ZipCodeError.format;
    if (int.tryParse(value) == null) return ZipCodeError.isPositive;
    if (value.length > 5) return ZipCodeError.maxLength;
    return null;
  }
}