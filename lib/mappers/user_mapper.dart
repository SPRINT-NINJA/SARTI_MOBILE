import 'package:sarti_mobile/models/user.dart';

import '../config/storage/key_value_storage.dart';

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

  static fromToken(String token) {
    final jwt = decodeToken(token);
    return User(
      email: jwt.payload['sub'] ?? '',
      role: jwt.payload['role']?[0]?['authority'] ?? '',
      token: token,
      password: '',
      id: jwt.payload['id'] ?? 0,
      blocked: jwt.payload['blocked'] ?? false,
      status: jwt.payload['status'] ?? false,
      verified: true,
      lastAccess: DateTime.now().toString(),
      createdAt: jwt.payload['createdAt'] ?? '',
      updatedAt: jwt.payload['updatedAt'] ?? '',
    );
  }
}
