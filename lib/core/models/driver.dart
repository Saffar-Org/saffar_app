import 'package:saffar_app/core/utils/model_helper.dart';

class Driver {
  const Driver({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.vehicleName,
    required this.vehicleNumber,
    this.imageUrl,
    required this.active,
  });

  final String id;
  final String name;
  final String phone;
  final String? email;
  final String vehicleName;
  final String vehicleNumber;
  final String? imageUrl;
  final bool active;

  /// Converts a map to a `Driver` instance.
  factory Driver.fromMap(Map<String, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Driver',
      map,
      [
        'id',
        'name',
        'phone',
        'vehicleName',
        'vehicleNumber',
        'active',
      ],
    );

    return Driver(
      id: map['id'].toString(),
      name: map['name'].toString(),
      phone: map['phone'].toString(),
      email: map['email']?.toString(),
      vehicleName: map['vehicleName'].toString(),
      vehicleNumber: map['vehicleNumber'].toString(),
      imageUrl: map['imageUrl']?.toString(),
      active: map['active'] as bool,
    );
  }

  /// Converts a `Driver` instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'vehicleName': vehicleName,
      'vehicleNumber': vehicleNumber,
      'imageUrl': imageUrl,
      'active': active,
    };
  }
}
