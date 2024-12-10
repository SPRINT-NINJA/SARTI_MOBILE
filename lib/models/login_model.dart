class VerifyEmail {
  final String email;

  VerifyEmail({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}

class VerifyPassword {
  final String password;

  VerifyPassword({required this.password});

  Map<String, dynamic> toJson() {
    return {'password': password};
  }
}

class UserInfo {
  final String name;
  final String email;
  final String password;
  final String image;

  UserInfo({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }
}
