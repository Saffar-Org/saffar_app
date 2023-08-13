import 'package:saffar_app/core/models/driver.dart';
import 'package:saffar_app/core/utils/model_helper.dart';

import 'address.dart';
import '../../features/user/data/models/user.dart';

/// Ride from a taxi from source to destination.
class Ride {
  const Ride({
    required this.id,
    required this.user,
    required this.driver,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.startTime,
    this.endTime,
    required this.cancelled,
    required this.price,
    this.discountPrice,
  });

  final String id;
  final User user;
  final Driver driver;
  final Address sourceAddress;
  final Address destinationAddress;
  final DateTime startTime;
  final DateTime? endTime;
  final bool cancelled;
  final double price;
  final double? discountPrice;

  factory Ride.fromMap(Map<String, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Ride',
      map,
      [
        'id',
        'user',
        'driver',
        'source_address',
        'destination_address',
        'start_time',
        'price'
      ],
    );

    final DateTime? startTime = DateTime.tryParse(map['start_time'] as String);

    if (startTime == null) {
      throw Exception('Start time can not be parsed to DateTime.');
    }

    return Ride(
      id: map['id'] as String,
      user: User.fromMap(map['user']),
      driver: Driver.fromMap(map['driver']),
      sourceAddress:
          Address.fromMap(map['source_address'] as Map<dynamic, dynamic>),
      destinationAddress:
          Address.fromMap(map['destination_address'] as Map<dynamic, dynamic>),
      startTime: startTime,
      endTime: map['end_time'] != null
          ? DateTime.tryParse(map['end_time'] as String)
          : null,
      cancelled: map['cancelled'] != null ? map['cancelled'] as bool : false,
      price: double.parse(map['price'].toString()),
      discountPrice: map['discount_price'] != null
          ? double.tryParse(map['discount_price'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user.id,
      'driver_id': driver.id,
      'source_address': sourceAddress.toMap(),
      'destination_address': destinationAddress.toMap(),
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'cancelled': cancelled,
      'price': price,
      'discount_price': discountPrice,
    };
  }
}
