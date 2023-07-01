import 'package:saffar_app/core/utils/model_helper.dart';

/// Address 
class Address {
  const Address({
    required this.id,
    this.place,
    required this.street,
    required this.state,
    required this.country,
    this.pincode,
  });

  final String id;
  final String? place;
  final String street;
  final String state;
  final String country;
  final String? pincode;

  factory Address.fromMap(Map<dynamic, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Address',
      map,
      ['id', 'street', 'state', 'country'],
    );

    return Address(
      id: map['id'] as String,
      place: map['place'] as String?,
      street: map['street'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      pincode: map['pincode'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'street': street,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }
}
