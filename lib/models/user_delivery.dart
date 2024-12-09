
class UserDelivery {
  String name;
  String surname;
  String lastname;
  String profilePicture;
  String firstLastName;
  String secondLastName;
  String email;
  String password;

  UserDelivery({
    required this.name,
    required this.surname,
    required this.lastname,
    required this.profilePicture,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.password,
  });

  factory UserDelivery.fromJson(Map<String, dynamic> json) {
    return UserDelivery(
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'lastname': lastname,
      'profilePicture': profilePicture,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'email': email,
      'password': password,
    };
  }
  

}