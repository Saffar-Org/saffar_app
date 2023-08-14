import 'package:flutter/material.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/features/user/domain/usecases/get_token_from_local_storage_usecase.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_in_and_save_user_info_in_local_storage_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/sign_up_and_save_user_info_in_local_storage_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_confirm_password_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_name_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_password_usecase.dart';
import 'package:saffar_app/features/authentication/domain/usecases/validate_phone_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final SignUpAndSaveUserInLocalStorageUsecase
      _signUpAndSaveUserInLocalStorageUsecase =
      SignUpAndSaveUserInLocalStorageUsecase();
  final GetTokenFromLocalStorageUsecase _getTokenFromLocalStorageUsecase =
      GetTokenFromLocalStorageUsecase();

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

  /// Signs in user and gets user and token and emits 
  /// user and token and 
  /// shows failure message if sign in fails
  void signInGetUserAndTokenAndEmitThem(BuildContext context, String phone, String password) async {
    emit(state.copyWith(loading: true));

    final result = await _signInAndSaveUserInLocalStorageUsecase.call(
      phone,
      password,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show(l.message ?? 'Failed to Sign In');
      },
      (r) {
        final String? token = _getTokenFromLocalStorageUsecase.call();

        if (token != null) {
          context.read<UserCubit>().emitUserAndToken(r, token);
        }
      },
    );

    emit(state.copyWith(loading: false));
  }

  /// Signs up user and gets user and token emits 
  /// user and token and 
  /// shows failure message if sign up fails
  void signUpGetUserAndTokenAndEmitThem(
    BuildContext context,
    String name,
    String phone,
    String password,
  ) async {
    emit(state.copyWith(loading: true));

    final result = await _signUpAndSaveUserInLocalStorageUsecase.call(
      name,
      phone,
      password,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show(l.message ?? 'Failed to Sign Up');
      },
      (r) {
        final String? token = _getTokenFromLocalStorageUsecase.call();

        if (token != null) {
          context.read<UserCubit>().emitUserAndToken(r, token);
        }
      },
    );

    emit(state.copyWith(loading: false));
  }

  /// If in sign in screen to go to sign up screen and 
  /// vice versa
  void toggleAuthScreen() {
    emit(state.copyWith(signIn: !state.signIn));
  }
}
