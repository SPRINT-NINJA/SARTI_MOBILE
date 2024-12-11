import 'package:formz/formz.dart';

// Define input validation errors
enum WalletError { empty , format }

// Extend FormzInput and provide the input type and error type.
class Wallet extends FormzInput<String, WalletError> {

  static final RegExp emailRegExp = RegExp(
    r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Wallet.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Wallet.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == WalletError.empty) return 'El campo no puede estar vacío';
    if (displayError == WalletError.format) return 'El formato del correo no es válido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  WalletError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return WalletError.empty;
    if (!emailRegExp.hasMatch(value)) return WalletError.format;

    return null;
  }
}