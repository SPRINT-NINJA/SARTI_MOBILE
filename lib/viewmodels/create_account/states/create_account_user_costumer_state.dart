import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';


class CreateAccountUserCostumerState {
  final FormStatus formStatus;
  final double progress;
  final int totalSteps;
  final int currentStep;

  final List<bool> isStepPosted;
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
  final Country country;
  final State state;
  final City city;
  final Locality locality;
  final Colony colony;
  final Street street;
  final ZipCode zipCode;
  final ExternalNumber externalNumber;
  final InternalNumber internalNumber;
  final Reference reference;

  final AddressType addressType;

  const CreateAccountUserCostumerState({
    this.formStatus = FormStatus.invalid,
    this.progress = 0.0,
    this.totalSteps = 0,
    this.isStepPosted = const [],
    this.isStepValid = const [],
    this.isLoading = false,
    this.isSaved = false,
    this.currentStep = 0,
    // section personal
    this.name = const Name.pure(),
    this.surname = const Name.pure(),
    this.lastName = const Lastname.pure(),
    // section credentials
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    // section address
    this.country = const Country.pure(),
    this.state = const State.pure(),
    this.city = const City.pure(),
    this.locality = const Locality.pure(),
    this.colony = const Colony.pure(),
    this.street = const Street.pure(),
    this.zipCode = const ZipCode.pure(),
    this.externalNumber = const ExternalNumber.pure(),
    this.internalNumber = const InternalNumber.pure(),
    this.reference = const Reference.pure(),
    this.addressType = AddressType.address,
  });

  CreateAccountUserCostumerState copyWith({
    FormStatus? formStatus,
    double? progress,
    int? totalSteps,
    List<bool>? isStepPosted,
    List<bool>? isStepValid,
    bool? isLoading,
    bool? isSaved,
    int? currentStep,
    // section personal
    Name? name,
    Name? surname,
    Lastname? lastName,
    // section credentials
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    // section address
    Country? country,
    State? state,
    City? city,
    Locality? locality,
    Colony? colony,
    Street? street,
    ZipCode? zipCode,
    ExternalNumber? externalNumber,
    InternalNumber? internalNumber,
    Reference? reference,

  }) {
    return CreateAccountUserCostumerState(
      formStatus: formStatus ?? this.formStatus,
      progress: progress ?? this.progress,
      totalSteps: totalSteps ?? this.totalSteps,
      isStepPosted: isStepPosted ?? this.isStepPosted,
      isStepValid: isStepValid ?? this.isStepValid,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      currentStep: currentStep ?? this.currentStep,
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
      currentStep: $currentStep,
    )''';
  }



}


