import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/inputs/inputs.dart';


class CreateAccountUserSellerState {
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
  final StateAddress state;
  final City city;
  final Locality locality;
  final Colony colony;
  final Street street;
  final ZipCode zipCode;
  final ExternalNumber externalNumber;
  final InternalNumber internalNumber;
  final Reference reference;
  final AddressType addressType;

  //section business
  final BusinessName businessName;
  final BusinessDescription description;
  final Wallet wallet;

  const CreateAccountUserSellerState({
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
    this.state = const StateAddress.pure(),
    this.city = const City.pure(),
    this.locality = const Locality.pure(),
    this.colony = const Colony.pure(),
    this.street = const Street.pure(),
    this.zipCode = const ZipCode.pure(),
    this.externalNumber = const ExternalNumber.pure(),
    this.internalNumber = const InternalNumber.pure(),
    this.reference = const Reference.pure(),
    this.addressType = AddressType.address,

    //section business
    this.businessName = const BusinessName.pure(),
    this.description = const BusinessDescription.pure(),
    this.wallet = const Wallet.pure(),
  });

  CreateAccountUserSellerState copyWith({
    Name? name,
    Name? surname,
    Lastname? lastName,
    // section credentials
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    // section address
    Country? country,
    StateAddress? state,
    City? city,
    Locality? locality,
    Colony? colony,
    Street? street,
    ZipCode? zipCode,
    ExternalNumber? externalNumber,
    InternalNumber? internalNumber,
    Reference? reference,

    //section business
    BusinessName? businessName,
    BusinessDescription? description,
    Wallet? wallet,

  }) {
    return CreateAccountUserSellerState(
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

      //section business
      businessName: businessName ?? this.businessName,
      description: description ?? this.description,
      wallet: wallet ?? this.wallet,
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


}


