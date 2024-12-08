import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty , format }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {

  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z]+)(?=.*[._#]+)(?=.*[0-9]+)[a-zA-Z0-9._#]{3,}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == PasswordError.empty) return 'El campo no puede estar vacío';
    if (displayError == PasswordError.format) return 'La contraseña debe tener al menos 3 caracteres, un número, una letra mayúscula y un caracter especial';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (!passwordRegExp.hasMatch(value)) return PasswordError.format;

    return null;
  }
}