class OrderDelivery {
  final int id;
  final String? orderNumber;
  final String? paypalOrderId;
  final String? orderDeliveryType;
  final String? orderDeliveryStep;
  final double fee;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SartiOrder? sartiOrder;
  final DeliveryMan? deliveryMan;
  final Address? address;

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
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
    sartiOrder: json["sartiOrder"] == null ? SartiOrder(id: 0, total: 0, createdAt: DateTime.now(), updatedAt: DateTime.now(), customer: Customer(id: 0, customerNumber: '', name: '', firstLastName: '', secondLastName: '', createdAt: DateTime.now(), updatedAt: DateTime.now()), seller: Seller(id: 0, sellerNumber: '', name: '', fistLastName: '', secondLastName: '', businessName: '', description: '', wallet: '', createdAt: DateTime.now(), updatedAt: DateTime.now()), productOrders: []) : SartiOrder.fromJson(json["sartiOrder"]),
    deliveryMan: json["deliveryMan"] == null ? DeliveryMan(id: 0, deliveryManNumber: '', name: '', firstLastName: '', secondLastName: '', isBusy: false, facePhoto: '', frontIdentificationPhoto: '', backIdentificationPhoto: '', createdAt: DateTime.now(), updatedAt: DateTime.now()) : DeliveryMan.fromJson(json["deliveryMan"]),
    address: json["address"] == null ? Address(id: 0, country: '', state: '', city: '', locality: '', colony: '', street: '', zipCode: 0, externalNumber: '', internalNumber: '', referenceNear: '', addressType: '', createdAt: DateTime.now(), updatedAt: DateTime.now()) : Address.fromJson(json["address"]),
  );
}

class SartiOrder {
  final int id;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Customer? customer;
  final Seller? seller;
  final List<ProductOrder>? productOrders;

  SartiOrder({
    required this.id,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    required this.seller,
    required this.productOrders,
  });

  factory SartiOrder.fromJson(Map<String, dynamic> json) => SartiOrder(
    id: json["id"],
    total: json["total"].toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
    customer: json["customer"] == null ? Customer(id: 0, customerNumber: '', name: '', firstLastName: '', secondLastName: '', createdAt: DateTime.now(), updatedAt: DateTime.now()) : Customer.fromJson(json["customer"]),
    seller: json["seller"] == null ? Seller(id: 0, sellerNumber: '', name: '', fistLastName: '', secondLastName: '', businessName: '', description: '', wallet: '', createdAt: DateTime.now(), updatedAt: DateTime.now()) : Seller.fromJson(json["seller"]),
    productOrders: (json["orderProducts"] as List).map((e) => ProductOrder.fromJson(e)).toList(),
  );
}

class Customer {
  final int id;
  final String? customerNumber;
  final String? name;
  final String? firstLastName;
  final String? secondLastName;
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
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
  );
}

// Similar classes for Seller, Product, Address, etc.

class DeliveryMan {
  final int id;
  final String? deliveryManNumber;
  final String? name;
  final String? firstLastName;
  final String? secondLastName;
  final bool isBusy;
  final String? facePhoto;
  final String? frontIdentificationPhoto;
  final String? backIdentificationPhoto;
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
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
  );
}

class Address {
  final int id;
  final String? country;
  final String? state;
  final String? city;
  final String? locality;
  final String? colony;
  final String? street;
  final int zipCode;
  final String? externalNumber;
  final String? internalNumber;
  final String? referenceNear;
  final String? addressType;
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
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
  );
}

// SELLER
class Seller {
  final int id;
  final String? sellerNumber;
  final String? name;
  final String? fistLastName;
  final String? secondLastName;
  final String? businessName;
  final String? description;
  final String? wallet;
  final DateTime createdAt;
  final DateTime updatedAt;

  Seller({
    required this.id,
    required this.sellerNumber,
    required this.name,
    required this.fistLastName,
    required this.secondLastName,
    required this.businessName,
    required this.description,
    required this.wallet,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    sellerNumber: json["sellerNumber"],
    name: json["name"],
    fistLastName: json["fistLastName"],
    secondLastName: json["secondLastName"],
    businessName: json["businessName"],
    description: json["description"],
    wallet: json["wallet"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
  );
}

//productOrders on SartiOrder
class ProductOrder {
  final int id;
  final String? productInfo;
  final int amount;
  final double total;
  final bool status;
  final Product? product;

  ProductOrder({
    required this.id,
    required this.productInfo,
    required this.amount,
    required this.total,
    required this.status,
    required this.product,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
    id: json["id"],
    productInfo: json["productInfo"],
    amount: json["amount"],
    total: json["total"].toDouble(),
    status: json["status"],
    product: json["product"] == null ? Product(id: 0, name: '', description: '', price: 0, mainImage: '', stock: 0, rating: 0, status: false, createdAt: DateTime.now(), updatedAt: DateTime.now(), seller: Seller(id: 0, sellerNumber: '', name: '', fistLastName: '', secondLastName: '', businessName: '', description: '', wallet: '', createdAt: DateTime.now(), updatedAt: DateTime.now())) : Product.fromJson(json["product"]),
  );
}


//products on productOrder
class Product {
  final int id;
  final String? name;
  final String? description;
  final double price;
  final String? mainImage;
  final int stock;
  final double rating;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Seller? seller;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.mainImage,
    required this.stock,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.seller,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"].toDouble(),
    mainImage: json["mainImage"],
    stock: json["stock"],
    rating: json["rating"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"] ?? json["createdAt"]),
    seller: null,
  );
}


