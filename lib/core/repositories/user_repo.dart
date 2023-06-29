import 'package:hive_flutter/adapters.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/service_locator.dart';

class UserRepo {
  UserRepo._();

  static UserRepo? _instance;

  /// Singleton instance of UserRepo also opening
  /// 'user_box' once when the app is running.
  static Future<UserRepo> get instance async {
    // If [_instance] is null 'user_box' is opened
    // and _instance is set to constructor of UserRepo.
    if (_instance == null) {
      _userBox = await _hive.openBox('user_box');
      _instance = UserRepo._();
    }

    return _instance!;
  }

  static final HiveInterface _hive = sl<HiveInterface>();
  static late final Box _userBox;

  /// Writes user map info to local storage
  Future<void> putUserMapInLocalStorage(Map<dynamic, dynamic> userMap) async {
    try {
      await _userBox.put('current_user', userMap);
    } catch (e) {
      throw const CustomException(
        message: 'Failed to store user info in local storage.',
      );
    }
  }

  /// Reads user map info from local storage
  Map<dynamic, dynamic> getUserMapFromLocalStorage() {
    try {
      return _userBox.get('current_user');
    } catch (e) {
      throw const CustomException(
        message: 'Failed to get user info from local storage.',
      );
    }
  }
}
