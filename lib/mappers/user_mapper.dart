import 'package:sarti_mobile/mappers/address_mapper.dart';
import 'package:sarti_mobile/models/address.dart';
import 'package:sarti_mobile/models/user.dart';

class UserMapper {
  static jsonToModel(Map<String, dynamic> json) => User(
        name: json['name'] ?? '',
        firstLastName: json['firstLastName'] ?? '',
        secondLastName: json['secondLastName'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        address:  json['address'] != null ? AddressMapper.jsonToModel(json['address']) : const Address.pure(),
      );
}
