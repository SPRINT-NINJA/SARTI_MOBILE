import 'package:formz/formz.dart';

// Define input validation errors
enum BusinessNameError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class BusinessName extends FormzInput<String, BusinessNameError> {

  static final nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
  // Call super.pure to represent an unmodified form input.
  const BusinessName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const BusinessName.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == BusinessNameError.empty) return 'El campo no puede estar vacío';
    if (displayError == BusinessNameError.format) return 'El campo solo puede contener letras';
    if (displayError == BusinessNameError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == BusinessNameError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BusinessNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return BusinessNameError.empty;
    if (!nameRegExp.hasMatch(value)) return BusinessNameError.format;
    if (value.length < 4) return BusinessNameError.minLength;
    if (value.length > 45) return BusinessNameError.maxLength;


    return null;
  }
}