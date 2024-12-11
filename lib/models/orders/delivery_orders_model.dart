import 'dart:convert';

import '../sellers/seller_model.dart';

class OrderDelivery {
  final int id;
  final String orderNumber;
  final String paypalOrderId;
  final String orderDeliveryType;
  final String orderDeliveryStep;
  final double fee;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SartiOrder sartiOrder;
  final DeliveryMan deliveryMan;
  final Address address;

  OrderDelivery({
    required this.id,
    required this.orderNumber,
    required this.paypalOrderId,
    required this.orderDeliveryType,
    required this.orderDeliveryStep,
    required this.fee,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sartiOrder,
    required this.deliveryMan,
    required this.address,
  });

  factory OrderDelivery.fromJson(Map<String, dynamic> json) => OrderDelivery(
    id: json["id"],
    orderNumber: json["orderNumber"],
    paypalOrderId: json["paypalOrderId"],
    orderDeliveryType: json["orderDeliveryType"],
    orderDeliveryStep: json["orderDeliveryStep"],
    fee: json["fee"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    sartiOrder: SartiOrder.fromJson(json["sartiOrder"]),
    deliveryMan: DeliveryMan.fromJson(json["deliveryMan"]),
    address: Address.fromJson(json["address"]),
  );
}

class SartiOrder {
  final int id;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Customer customer;
  final Seller seller;

  SartiOrder({
    required this.id,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.seller,
  });

  factory SartiOrder.fromJson(Map<String, dynamic> json) => SartiOrder(
    id: json["id"],
    total: json["total"].toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    customer: Customer.fromJson(json["customer"]),
    seller: Seller.fromJson(json["seller"]),
  );
}

class Customer {
  final int id;
  final String customerNumber;
  final String name;
  final String firstLastName;
  final String secondLastName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    required this.id,
    required this.customerNumber,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    customerNumber: json["customerNumber"],
    name: json["name"],
    firstLastName: json["fistLastName"],
    secondLastName: json["secondLastName"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}

// Similar classes for Seller, Product, Address, etc.

class DeliveryMan {
  final int id;
  final String deliveryManNumber;
  final String name;
  final String firstLastName;
  final String secondLastName;
  final bool isBusy;
  final String facePhoto;
  final String frontIdentificationPhoto;
  final String backIdentificationPhoto;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeliveryMan({
    required this.id,
    required this.deliveryManNumber,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.isBusy,
    required this.facePhoto,
    required this.frontIdentificationPhoto,
    required this.backIdentificationPhoto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryMan.fromJson(Map<String, dynamic> json) => DeliveryMan(
    id: json["id"],
    deliveryManNumber: json["deliveryManNumber"],
    name: json["name"],
    firstLastName: json["fistLastName"],
    secondLastName: json["secondLastName"],
    isBusy: json["isBusy"],
    facePhoto: json["facePhoto"],
    frontIdentificationPhoto: json["frontIdentificationPhoto"],
    backIdentificationPhoto: json["backIdentificationPhoto"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
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
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    locality: json["locality"],
    colony: json["colony"],
    street: json["street"],
    zipCode: json["zipCode"],
    externalNumber: json["externalNumber"],
    internalNumber: json["internalNumber"],
    referenceNear: json["referenceNear"],
    addressType: json["addressType"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}
