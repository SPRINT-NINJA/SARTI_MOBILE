class User {
  final String email;
  final String role;

  User({
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
    };
  }
}

class Address {
  final int id;
  final String country;
  final String state;
  final String city;
  final String locality;
  final String colony;
  final String street;
  final int zipCode;
  final String externalNumber;
  final String internalNumber;
  final String referenceNear;
  final String addressType;

  Address({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.locality,
    required this.colony,
    required this.street,
    required this.zipCode,
    required this.externalNumber,
    required this.internalNumber,
    required this.referenceNear,
    required this.addressType,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      locality: json['locality'],
      colony: json['colony'],
      street: json['street'],
      zipCode: json['zipCode'],
      externalNumber: json['externalNumber'],
      internalNumber: json['internalNumber'],
      referenceNear: json['referenceNear'],
      addressType: json['addressType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'state': state,
      'city': city,
      'locality': locality,
      'colony': colony,
      'street': street,
      'zipCode': zipCode,
      'externalNumber': externalNumber,
      'internalNumber': internalNumber,
      'referenceNear': referenceNear,
      'addressType': addressType,
    };
  }
}

class ProfileSeller {
  final int id;
  final String sellerNumber;
  final String name;
  final String fistLastName;
  final String secondLastName;
  final String bussinessName;
  final String description;
  final String wallet;
  final String createdAt;
  final String? updatedAt;
  final User user;
  final Address address;

  ProfileSeller({
    required this.id,
    required this.sellerNumber,
    required this.name,
    required this.fistLastName,
    required this.secondLastName,
    required this.bussinessName,
    required this.description,
    required this.wallet,
    required this.createdAt,
    this.updatedAt,
    required this.user,
    required this.address,
  });

  factory ProfileSeller.fromJson(Map<String, dynamic> json) {
    return ProfileSeller(
      id: json['id'],
      sellerNumber: json['sellerNumber'],
      name: json['name'],
      fistLastName: json['fistLastName'],
      secondLastName: json['secondLastName'],
      bussinessName: json['bussinessName'],
      description: json['description'],
      wallet: json['wallet'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: User.fromJson(json['user']),
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sellerNumber': sellerNumber,
      'name': name,
      'fistLastName': fistLastName,
      'secondLastName': secondLastName,
      'bussinessName': bussinessName,
      'description': description,
      'wallet': wallet,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user.toJson(),
      'address': address.toJson(),
    };
  }
}
