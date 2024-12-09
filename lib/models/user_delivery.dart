
class UserDelivery {
  String name;
  String firstLastName;
  String secondLastName;
  String email;
  String password;
  String profilePicture;
  String frontIdentification;
  String backIdentification;

  UserDelivery({
    required this.name,
    required this.profilePicture,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.password,
    required this.frontIdentification,
    required this.backIdentification,
  });

  factory UserDelivery.fromJson(Map<String, dynamic> json) {
    return UserDelivery(
      name: json['name'],
      profilePicture: json['profilePicture'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      password: json['password'],
      frontIdentification: json['frontIdentification'],
      backIdentification: json['backIdentification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'email': email,
      'password': password,
      'frontIdentification': frontIdentification,
      'backIdentification': backIdentification,
    };
  }
  

}