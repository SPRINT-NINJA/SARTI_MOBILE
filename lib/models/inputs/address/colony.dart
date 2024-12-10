import 'package:formz/formz.dart';

// Define input validation errors
enum ColonyError { empty , minLength, maxLength, format }

// Extend FormzInput and provide the input type and error type.
class Colony extends FormzInput<String, ColonyError> {

  static final colonyRegExp = RegExp(r'^(?!.*\s{2})[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s]+$');
  // Call super.pure to represent an unmodified form input.
  const Colony.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Colony.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ColonyError.empty) return 'El campo no puede estar vacío';
    if (displayError == ColonyError.format) return 'No se aceptan caracteres especiales';
    if (displayError == ColonyError.minLength) return 'El campo debe tener al menos 4 caracteres';
    if (displayError == ColonyError.maxLength) return 'El campo no puede tener más de 45 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ColonyError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ColonyError.empty;
    if (!colonyRegExp.hasMatch(value)) return ColonyError.format;
    if (value.length < 4) return ColonyError.minLength;
    if (value.length > 45) return ColonyError.maxLength;
    return null;
  }
}