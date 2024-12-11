import 'package:formz/formz.dart';

// Define input validation errors
enum BusinessDescriptionError { empty , format , minLength, maxLength }

// Extend FormzInput and provide the input type and error type.
class BusinessDescription extends FormzInput<String, BusinessDescriptionError> {

  static final RegExp descriptionRegExp = RegExp(
    r'^[a-zA-Z0-9 .\-()]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const BusinessDescription.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const BusinessDescription.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == BusinessDescriptionError.empty) return 'El campo no puede estar vacío';
    if (displayError == BusinessDescriptionError.format) return 'El campo solo puede contener letras, números y los siguientes caracteres: . - ( )';
    if (displayError == BusinessDescriptionError.minLength) return 'El campo debe tener al menos 45 caracteres';
    if (displayError == BusinessDescriptionError.maxLength) return 'El campo no puede tener más de 255 caracteres';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BusinessDescriptionError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return BusinessDescriptionError.empty;
    if (!descriptionRegExp.hasMatch(value)) return BusinessDescriptionError.format;
    if (value.length < 45) return BusinessDescriptionError.minLength;
    if (value.length > 255) return BusinessDescriptionError.maxLength;

    return null;
  }
}