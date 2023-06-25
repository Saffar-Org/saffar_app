import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_up_usecase.dart';
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
  final SignInUsecase _signInUsecase = SignInUsecase();
  final SignUpUsecase _signUpUsecase = SignUpUsecase();

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
    final result = await _signInUsecase.call(phone, password);

    result.fold((l) {
      Snackbar.of(context).show(l.message ?? 'Failed to Sign In');
    }, (r) {
      print(r.toMap());
    });
  }
}
