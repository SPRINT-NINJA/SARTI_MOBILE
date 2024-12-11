import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmPasswordError { empty, mismatch }

// Extend FormzInput and provide the input type and error type.
class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {
  final String password;

  // Pass the original password for comparison.
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  String? get errMsg {
    if (isValid || isPure) return null;
    if (displayError == ConfirmPasswordError.empty) return 'El campo no puede estar vacío';
    if (displayError == ConfirmPasswordError.mismatch) return 'Las contraseñas no coinciden';
    return null;
  }

  @override
  ConfirmPasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ConfirmPasswordError.empty;
    if (value != password) return ConfirmPasswordError.mismatch;
    return null;
  }
}
