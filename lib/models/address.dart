import 'package:sarti_mobile/config/config.dart';

class Address {
  final String country;
  final String state;
  final String city;
  final String locality;
  final String colony;
  final String street;
  final String zipCode;
  final String externalNumber;
  final String internalNumber;
  final String referenceNear;
  final AddressType addressType;


  const Address({
    required this.country,
    required this.state,
    required this.city,
    required this.locality,
    required this.colony,
    required this.street,
    required this.zipCode,
    required this.externalNumber,
    required this.internalNumber,
    required this.referenceNear,
    this.addressType = AddressType.address
  });

  const Address.pure() : this(
    country: '',
    state: '',
    city: '',
    locality: '',
    colony: '',
    street: '',
    zipCode: '',
    externalNumber: '',
    internalNumber: '',
    referenceNear: '',
    addressType: AddressType.address
  );



  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      state: json['state'],
      city: json['city'],
      locality: json['locality'],
      colony: json['colony'],
      street: json['street'],
      zipCode: json['zipCode'],
      externalNumber: json['externalNumber'],
      internalNumber: json['internalNumber'],
      referenceNear: json['referenceNear'],
      addressType: AddressType.values.firstWhere((element) => element.toString() == json['addressType'])
    );
  }

  Address copyWith({
    String? country,
    String? state,
    String? city,
    String? locality,
    String? colony,
    String? street,
    String? zipCode,
    String? externalNumber,
    String? internalNumber,
    String? referenceNear,
    AddressType? addressType,
  }) {
    return Address(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      locality: locality ?? this.locality,
      colony: colony ?? this.colony,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      externalNumber: externalNumber ?? this.externalNumber,
      internalNumber: internalNumber ?? this.internalNumber,
      referenceNear: referenceNear ?? this.referenceNear,
      addressType: addressType ?? this.addressType
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'city': city,
      'locality': locality,
      'colony': colony,
      'street': street,
      'zipCode': zipCode,
      'externalNumber': externalNumber,
      'internalNumber': internalNumber,
      'referenceNear': referenceNear,
      'addressType': addressType.toString()
    };
  }



}