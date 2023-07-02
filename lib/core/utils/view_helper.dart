import 'package:saffar_app/core/models/address.dart';

class ViewHelper {
  /// Gets the address without the place if place is present.
  /// If place is [null] then gets address without place and street.
  static String getAddressWithoutPlace(Address address) {
    String res = '';
    if (address.place != null) {
      res = res + '${address.street}, ';
    }

    res = res + '${address.state}, ${address.country}';

    if (address.pincode != null) {
      res = res + ', ${address.pincode}';
    }

    return res;
  }

  /// Returns place is place is not null else returns street.
  static String getAddressPlace(Address address) {
    return address.place ?? address.street;
  }
}