import 'package:formz/formz.dart';

// Define input validation errors
enum DescriptionError { empty , format , minLength, maxLength }

// Extend FormzInput and provide the input type and error type.
class Description extends FormzInput<String, DescriptionError> {

  static final RegExp descriptionRegExp = RegExp(
    r'^[a-zA-Z0-9 .\-()]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const Description.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Description.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == DescriptionError.empty) return 'El campo no puede estar vacío';
    if (displayError == DescriptionError.format) return 'El campo solo puede contener letras, números y los siguientes caracteres: . - ( )';
    if (displayError == DescriptionError.minLength) return 'El campo debe tener al menos 45 caracteres';
    if (displayError == DescriptionError.maxLength) return 'El campo no puede tener más de 255 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DescriptionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DescriptionError.empty;
    if (!descriptionRegExp.hasMatch(value)) return DescriptionError.format;
    if (value.length < 45) return DescriptionError.minLength;
    if (value.length > 255) return DescriptionError.maxLength;

    return null;
  }
}