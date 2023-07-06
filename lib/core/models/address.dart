import 'package:saffar_app/core/utils/model_helper.dart';
import 'package:latlong2/latlong.dart';

/// Address
class Address {
  const Address({
    required this.id,
    this.place,
    required this.street,
    this.state,
    this.country,
    required this.latLng,
    this.pincode,
  });

  final String id;
  final String? place;
  final String street;
  final String? state;
  final String? country;
  final LatLng latLng;
  final String? pincode;

  factory Address.fromMap(Map<dynamic, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Address',
      map,
      [
        'id',
        'street',
        'state',
        'country',
        'lat',
        'lon',
      ],
    );

    final double? lat = double.tryParse(map['lat'].toString());
    final double? lon = double.tryParse(map['lon'].toString());

    if (lat == null || lon == null) {
      throw Exception('Model Address: Address has no lat lon.');
    }

    return Address(
      id: map['id'].toString(),
      place: map['place']?.toString(),
      street: map['street'].toString(),
      state: map['state'].toString(),
      country: map['country'].toString(),
      latLng: LatLng(lat, lon),
      pincode: map['pincode'] as String?,
    );
  }

  /// Converts a JSON that is received from TomTom Places API
  /// to a Address Model.
  factory Address.fromPlacesApiResponseMap(Map<String, dynamic> map) {
    map['address'].forEach((key, value) => {key: value});
    map['position'].forEach((key, value) => {key: value});

    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Address',
      map,
      [
        'id',
        'address',
        'position',
      ],
    );

    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Address',
      map['position'],
      [
        'lat',
        'lon',
      ],
    );

    final double? lat = double.tryParse(map['position']['lat'].toString());
    final double? lon = double.tryParse(map['position']['lon'].toString());

    if (lat == null || lon == null) {
      throw Exception('Model Address: Address has no lat lon.');
    }

    return Address(
      id: map['id'].toString(),
      place: map['address']['localName']?.toString(),
      street: map['address']['streetName'] != null
          ? map['address']['streetName'].toString()
          : 'Unnamed Road',
      state: map['address']['countrySubdivision'].toString(),
      country: map['address']['country']?.toString(),
      latLng: LatLng(lat, lon),
      pincode: map['address']['postalCode']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'street': street,
      'state': state,
      'country': country,
      'lat': latLng.latitude,
      'lon': latLng.longitude,
      'pincode': pincode,
    };
  }
}
