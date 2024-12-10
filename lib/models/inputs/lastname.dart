import 'package:formz/formz.dart';

// Define input validation errors
enum LastnameError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Lastname extends FormzInput<String, LastnameError> {

  static final lastnameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Lastname.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Lastname.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == LastnameError.format) return 'El campo solo puede contener letras';
    if (displayError == LastnameError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == LastnameError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  LastnameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return null;
    if (!lastnameRegExp.hasMatch(value)) return LastnameError.format;
    if (value.length < 4) return LastnameError.minLength;
    if (value.length > 45) return LastnameError.maxLength;
    return null;
  }
}