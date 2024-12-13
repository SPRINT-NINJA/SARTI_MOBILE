enum FormStatus { invalid, valid, validating, submitting, submitted, posting }


enum AddressType { address, office, home, business , other }

String addressTypeToString(AddressType addressType) {
  switch (addressType) {
    case AddressType.address:
      return 'DOMICILIO';
    case AddressType.office:
      return 'Oficina';
    case AddressType.home:
      return 'Casa';
    case AddressType.business:
      return 'Negocio';
    case AddressType.other:
      return 'Otro';
    default:
      return 'Domicilio';
  }
}

const Map<Role, String> roleMap = {
  Role.delivery: 'REPARTIDOR',
  Role.customer: 'COMPRADOR',
  Role.seller: 'EMPRENDEDOR',
  Role.public: 'PUBLICO',
};

enum Role { delivery, customer, seller, public }

Role? getRoleFromString(String roleString) {
  try {
    return roleMap.entries.firstWhere((entry) => entry.value == roleString).key;
  } catch (e) {
    return null;
  }
}
String getRoleString(Role role) {
  return roleMap[role] ?? 'COMPRADOR';
}

