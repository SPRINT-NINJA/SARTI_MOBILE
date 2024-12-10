import 'package:formz/formz.dart';

// Define input validation errors
enum NameError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameError> {

  static final nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == NameError.empty) return 'El campo no puede estar vacío';
    if (displayError == NameError.format) return 'El campo solo puede contener letras';
    if (displayError == NameError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == NameError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (!nameRegExp.hasMatch(value)) return NameError.format;
    if (value.length < 4) return NameError.minLength;
    if (value.length > 45) return NameError.maxLength;


    return null;
  }
}