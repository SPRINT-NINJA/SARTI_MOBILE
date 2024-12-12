import 'package:sarti_mobile/config/config.dart';
import 'package:sarti_mobile/models/address.dart';

class AddressMapper {
  static jsonToModel(Map<String, dynamic> json) => Address(
      locality: json['locality'] ?? '',
      colony: json['colony'] ?? '',
      externalNumber: json['externalNumber'] ?? '',
      internalNumber: json['internalNumber'] ?? '',
      referenceNear: json['referenceNear'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
      addressType: AddressType.values.firstWhere((element) => element.toString() == json['addressType']));
}
