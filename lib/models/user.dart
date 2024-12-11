
import 'package:sarti_mobile/models/address.dart';

class User {
  String name;
  String firstLastName;
  String secondLastName;
  String email;
  String password;
  Address address;


  User({
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.password,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

  @override
  String toString() {
    return 'User{name: $name, firstLastName: $firstLastName, secondLastName: $secondLastName, email: $email, password: $password, address: $address}';
  }


}