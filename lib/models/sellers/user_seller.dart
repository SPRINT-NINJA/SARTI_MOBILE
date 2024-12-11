
import 'package:sarti_mobile/models/address.dart';

class UserSeller {
  String name;
  String firstLastName;
  String secondLastName;
  String email;
  String password;
  Address address;


  UserSeller({
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.password,
    required this.address,
  });

  factory UserSeller.fromJson(Map<String, dynamic> json) {
    return UserSeller(
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      password: json['password'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'email': email,
      'password': password,
      'address': address.toJson(),
    };
  }


}