import 'package:saffar_app/core/models/address.dart';

class ViewHelper {
  /// Gest the total address like 'Place, Road, State, Country, Pincode'
  static String getAddress(Address address) {
    String res = '';

    if (address.place != null) {
      res = '${address.place} ${getAddressWithoutPlace(address)}';
    } else {
      res = getAddressWithoutPlace(address);
    }

    return res;
  }

  /// Gets the address without the place
  static String getAddressWithoutPlace(Address address) {
    String res = address.street.toString();

    if (address.state != null) {
      res = res + ', ${address.state}';
    }

    if (address.country != null) {
      res = res + ', ${address.country}';
    }

    if (address.pincode != null) {
      res = res + ', ${address.pincode}';
    }

    return res;
  }

  /// Returns place if place is not null else returns street.
  static String getAddressPlace(Address address) {
    return address.place ?? address.street;
  }
}
