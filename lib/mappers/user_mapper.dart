import 'package:sarti_mobile/models/user.dart';

class UserMapper {
  static jsonToModel(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        token: json['token'],
        role: json['role'],
        blocked: json['blocked'],
        status: json['status'],
        verified: json['verified'],
        lastAccess: json['lastAccess'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
