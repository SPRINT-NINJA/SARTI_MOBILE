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