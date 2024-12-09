import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';

enum AdressType { DOMICILIO, OFICINA }

class CreateAccountUserDeliveryState {
  final FormStatus formStatus;
  final double progress;
  final int totalSteps;

  final List<String> isStepPosted;
  final List<bool> isStepValid;
  final bool isLoading;
  final bool isSaved;

  // section personal
  final Name name;
  final Name surname;
  final Lastname lastName;

  // section credentials
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  // section address
  final String country;
  final String state;
  final String city;
  final String locality;
  final String colony;
  final String street;
  final String zipCode;
  final String externalNumber;
  final String internalNumber;
  final String reference;
  final AdressType addressType;

  const CreateAccountUserDeliveryState({
    this.formStatus = FormStatus.invalid,
    this.progress = 0.0,
    this.totalSteps = 0,
    this.isStepPosted = const [],
    this.isStepValid = const [],
    this.isLoading = false,
    this.isSaved = false,
    // section personal
    this.name = const Name.pure(),
    this.surname = const Name.pure(),
    this.lastName = const Lastname.pure(),
    // section credentials
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    // section address
    this.country = '',
    this.state = '',
    this.city = '',
    this.locality = '',
    this.colony = '',
    this.street = '',
    this.zipCode = '',
    this.externalNumber = '',
    this.internalNumber = '',
    this.reference = '',
    this.addressType = AdressType.DOMICILIO,
  });

  CreateAccountUserDeliveryState copyWith({
    FormStatus? formStatus,
    double? progress,
    int? totalSteps,
    List<String>? isStepPosted,
    List<bool>? isStepValid,
    bool? isLoading,
    bool? isSaved,
    // section personal
    Name? name,
    Name? surname,
    Lastname? lastName,
    // section credentials
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    // section address
    String? country,
    String? state,
    String? city,
    String? locality,
    String? colony,
    String? street,
    String? zipCode,
    String? externalNumber,
    String? internalNumber,
    String? reference,
  }) {
    return CreateAccountUserDeliveryState(
      formStatus: formStatus ?? this.formStatus,
      progress: progress ?? this.progress,
      totalSteps: totalSteps ?? this.totalSteps,
      isStepPosted: isStepPosted ?? this.isStepPosted,
      isStepValid: isStepValid ?? this.isStepValid,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      // section personal
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lastName: lastName ?? this.lastName,
      // section credentials
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      // section address
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      locality: locality ?? this.locality,
      colony: colony ?? this.colony,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      externalNumber: externalNumber ?? this.externalNumber,
      internalNumber: internalNumber ?? this.internalNumber,
      reference: reference ?? this.reference,
    );
  }

  @override
  String toString() {
    return '''CreateAccountUserDeliveryState(
      name: $name,
      surname: $surname,
      lastName: $lastName,
      email: $email,
      password: $password,
      confirmPassword: $confirmPassword,
      country: $country,
      state: $state,
      city: $city,
      locality: $locality,
      colony: $colony,
      street: $street,
      zipCode: $zipCode,
      externalNumber: $externalNumber,
      internalNumber: $internalNumber,
      reference: $reference,
    )''';
  }

  String toStringForm() {
    return '''CreateAccountUserDeliveryState(
      formStatus: $formStatus,
      progress: $progress,
      totalSteps: $totalSteps,
      isStepPosted: $isStepPosted,
      isStepValid: $isStepValid,
      isLoading: $isLoading,
      isSaved: $isSaved,
    )''';
  }
}
