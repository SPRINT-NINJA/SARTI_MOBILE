enum ERoles {
  delivery,
  costumer,
  business,
}


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

const Map<role, String> roleMap = {
  role.delivery: 'REPARTIDOR',
  role.customer: 'COMPRADOR',
  role.seller: 'EMPRENDEDOR',
};

enum role { delivery, customer, seller }

role? getRoleFromString(String roleString) {
  try {
    return roleMap.entries.firstWhere((entry) => entry.value == roleString).key;
  } catch (e) {
    return null;
  }
}
String getRoleString(role role) {
  return roleMap[role] ?? 'COMPRADOR';
}

