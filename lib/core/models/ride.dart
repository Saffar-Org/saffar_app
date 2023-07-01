import 'package:saffar_app/core/utils/model_helper.dart';

import 'address.dart';

/// Ride from a taxi from source to destination.
class Ride {
  const Ride({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.sourceAddress,
    required this.destinationAddress,
    this.startTime,
    this.endTime,
    required this.cancelled,
    required this.price,
    this.discountPrice,
  });

  final String id;
  final String userId;
  final String driverId;
  final Address sourceAddress;
  final Address destinationAddress;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool cancelled;
  final double price;
  final double? discountPrice;

  factory Ride.fromMap(Map<dynamic, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'Ride',
      map,
      [
        'id',
        'user_id',
        'driver_id',
        'source_address',
        'destination_address',
        'price'
      ],
    );

    return Ride(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      driverId: map['driver_id'] as String,
      sourceAddress:
          Address.fromMap(map['source_address'] as Map<dynamic, dynamic>),
      destinationAddress:
          Address.fromMap(map['destination_address'] as Map<dynamic, dynamic>),
      startTime: map['start_time'] != null
          ? DateTime.tryParse(map['start_time'] as String)
          : null,
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
      'user_id': userId,
      'driver_id': driverId,
      'source_address': sourceAddress.toMap(),
      'destination_address': destinationAddress.toMap(),
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'cancelled': cancelled,
      'price': price,
      'discount_price': discountPrice,
    };
  }
}
