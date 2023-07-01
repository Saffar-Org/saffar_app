import 'package:saffar_app/core/utils/model_helper.dart';

/// User 
class User {
  const User({
    required this.id,
    required this.token,
    required this.name,
    required this.phone,
    this.email,
    this.imageUrl,
  });

  final String id;
  final String token;
  final String name;
  final String phone;
  final String? email;
  final String? imageUrl;

  factory User.fromMap(Map<dynamic, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'User',
      map,
      ['id', 'token', 'name', 'phone'],
    );

    return User(
      id: map['id'],
      token: map['token'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      imageUrl: map['imageUrl'],
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
    };
  }
}
