import 'package:hive_flutter/adapters.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/service_locator.dart';

class UserRepo {
  final HiveInterface _hive = sl<HiveInterface>();
  Box? _userBox;

  /// Initialize User Repo. This function should be
  /// called once in the application before using
  /// any of the other functions of [UserRepo].
  /// Preferrably in the Splash Screen.
  Future<void> initUserRepo() async {
    try {
      _userBox = await _hive.openBox('user_box');
    } catch (e) {
      throw CustomException(
        message: e.toString(),
      );
    }
  }

  /// Writes user map info to local storage
  Future<void> putUserMapInLocalStorage(Map<dynamic, dynamic> userMap) async {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      await _userBox!.put('current_user', userMap);
    } catch (e) {
      throw const CustomException(
        message: 'Failed to store user info in local storage.',
      );
    }
  }

  /// Writes token to local storage
  Future<void> putTokenInLocalStorage(String token) async {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      await _userBox!.put('token', token);
    } catch (e) {
      throw const CustomException(
        message: 'Failed to store token in local storage.',
      );
    }
  }

  /// Reads user map info from local storage
  Map<dynamic, dynamic> getUserMapFromLocalStorage() {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      return _userBox!.get('current_user');
    } catch (e) {
      throw const CustomException(
        message: 'Failed to get user info from local storage.',
      );
    }
  }

  /// Reads token from local storage
  String getTokenFromLocalStorage() {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      return _userBox!.get('token');
    } catch (e) {
      throw const CustomException(
        message: 'Failed to get token from local storage.',
      );
    }
  }

  /// Deletes token from local storage
  Future<bool> deleteTokenFromLocalStorage() async {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      await _userBox!.delete('token');

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Deletes user from local storage
  Future<bool> deleteUserFromLocalStorage() async {
    if (_userBox == null) {
      throw const CustomException(message: 'User box is null.');
    }

    try {
      await _userBox!.delete('current_user');

      return true;
    } catch (e) {
      return false;
    }
  }
}
