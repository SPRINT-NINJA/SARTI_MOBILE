class VerifyEmail {
  final String email;

  VerifyEmail({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

class RecoveryPassword {
  final String code;
  final String password;

  RecoveryPassword({required this.code, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'password': password,
    };
  }
}
