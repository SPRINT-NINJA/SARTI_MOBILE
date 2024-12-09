import 'package:sarti_mobile/models/models.dart';

class UserDeliveryMapper {


  static jsonToModel(Map<String, dynamic> json) => UserDelivery(
    name: json['name'],
    surname: json['surname'],
    lastname: json['lastname'],
    profilePicture: json['profilePicture'],
    firstLastName: json['firstLastName'],
    secondLastName: json['secondLastName'],
    email: json['email'],
    password: json['password'],
  );
}