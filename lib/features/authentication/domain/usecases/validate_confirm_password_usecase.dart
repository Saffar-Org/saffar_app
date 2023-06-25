class ValidateConfirmPasswordUsecase {
  /// Checks if confirm password is empty or not and if it is 
  /// same as password or not. If not then the function will
  /// return a error message else it will return null
  String? call(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password can not be empty';
    }

    if (password != confirmPassword) {
      return 'Confirm password must be same as password';
    }

    return null;
  }
}
