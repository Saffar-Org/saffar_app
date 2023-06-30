import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_in_and_save_user_info_in_local_storage_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_up_and_save_user_info_in_local_storage_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_confirm_password_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_name_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_password_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_phone_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  final ValidateNameUsecase _validateNameUsecase = ValidateNameUsecase();
  final ValidatePhoneUsecase _validatePhoneUsecase = ValidatePhoneUsecase();
  final ValidatePasswordUsecase _validatePasswordUsecase =
      ValidatePasswordUsecase();
  final ValidateConfirmPasswordUsecase _validateConfirmPasswordUsecase =
      ValidateConfirmPasswordUsecase();
  final SignInAndSaveUserInLocalStorageUsecase
      _signInAndSaveUserInLocalStorageUsecase =
      SignInAndSaveUserInLocalStorageUsecase();
  final SignUpAndSaveUserInLocalStorageUsecase _signUpAndSaveUserInLocalStorageUsecase = SignUpAndSaveUserInLocalStorageUsecase();

  /// Validates name
  String? validateName(String? name) {
    return _validateNameUsecase.call(name);
  }

  /// Validates phone number
  String? validatePhone(String? phone) {
    return _validatePhoneUsecase.call(phone);
  }

  /// Validates password
  String? validatePassword(String? password) {
    return _validatePasswordUsecase.call(password);
  }

  /// Validates confirm password
  String? validateConfirmPassword(String? password, String? confirmPassword) {
    return _validateConfirmPasswordUsecase.call(password, confirmPassword);
  }

  /// Signs in user and shows failure message if sign in fails
  void signIn(BuildContext context, String phone, String password) async {
    emit(const AuthState(loading: true));

    final result = await _signInAndSaveUserInLocalStorageUsecase.call(
      context,
      phone,
      password,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show(l.message ?? 'Failed to Sign In');
      },
      (r) {},
    );

    emit(const AuthState());
  }

  /// Signs up user and shows failure message if sign up fails
  void signUp(
    BuildContext context,
    String name,
    String phone,
    String password,
  ) async {
    emit(const AuthState(loading: true));

    final result = await _signUpAndSaveUserInLocalStorageUsecase.call(
      context,
      name,
      phone,
      password,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show(l.message ?? 'Failed to Sign Up');
      },
      (r) {},
    );

    emit(const AuthState());
  }
}
