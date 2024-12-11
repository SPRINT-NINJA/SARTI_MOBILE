import 'package:formz/formz.dart';

// Define input validation errors
enum ImageIdError { empty }

// Extend FormzInput and provide the input type and error type.
class ImageId extends FormzInput<String, ImageIdError> {

  // Call super.pure to represent an unmodified form input.
  const ImageId.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ImageId.dirty(String value) : super.dirty(value);

  String? get errMsg{
    if (isValid || isPure) return null;
    if (displayError == ImageIdError.empty) return 'Es necesario seleccionar una imagen';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ImageIdError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ImageIdError.empty;
    return null;
  }
}