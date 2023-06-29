class User {
  const User({
    required this.id,
    required this.token,
    required this.name,
    required this.phone,
    this.email,
    this.imageUrl,
    this.latitude,
    this.longitude,
    this.rides = const [],
  });

  final String id;
  final String token;
  final String name;
  final String phone;
  final String? email;
  final String? imageUrl;
  final double? latitude;
  final double? longitude;
  final List<dynamic> rides; // TODO: Change dynamic with Ride model

  factory User.fromMap(Map<dynamic, dynamic> map) {
    if (map['id'] == null || map['id'] == '') {
      throw Exception('Model User: User has no id');
    } else if (map['token'] == null || map['token'] == '') {
      throw Exception('Model User: User has no token');
    } else if (map['name'] == null || map['name'] == '') {
      throw Exception('Model User: User has no name');
    } else if (map['phone'] == null || map['phone'] == '') {
      throw Exception('Model User: User has no phone number');
    }

    return User(
      id: map['id'],
      token: map['token'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      rides: map['rides'] != null
          ? List<dynamic>.from(map['rides'])
          : [], // TODO: Change dynamic with Review model
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'phone': phone,
      'email': email,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'rides': rides,
    };
  }
}
