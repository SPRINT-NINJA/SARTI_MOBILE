import 'package:sarti_mobile/models/inputs/inputs.dart';

enum FormStatus { invalid, valid, validating, submitting, submitted, posting }


class CreateAccountDeliveryProvider {
  final FormStatus formStatus;
  final bool isFormPosted;
  final bool isValid;
  final Name name;

  const CreateAccountDeliveryProvider({
    this.formStatus = FormStatus.invalid,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
  });
}