class User {
  int id;
  String email;
  String password;
  String token;
  String role;
  bool blocked;
  bool status;
  bool verified;
  String lastAccess;
  String createdAt;
  String updatedAt;


  User({
    required this.id,
    required this.email,
    required this.password,
    required this.token,
    required this.role,
    required this.blocked,
    required this.status,
    required this.verified,
    required this.lastAccess,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? token,
    String? role,
    bool? blocked,
    bool? status,
    bool? verified,
    String? lastAccess,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      role: role ?? this.role,
      blocked: blocked ?? this.blocked,
      status: status ?? this.status,
      verified: verified ?? this.verified,
      lastAccess: lastAccess ?? this.lastAccess,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'token': token,
      'role': role,
      'blocked': blocked,
      'status': status,
      'verified': verified,
      'lastAccess': lastAccess,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password, token: $token, role: $role, blocked: $blocked, status: $status, verified: $verified, lastAccess: $lastAccess, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}