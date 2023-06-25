/// Handles validation
class Validator {
  /// Validates email using Regular Expression
  bool validateEmail(String email) {
    // Regular expression pattern for email validation
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );

    return emailRegex.hasMatch(email);
  }

  /// Validates password if its length is more then or 
  /// equal to 8
  bool validatePassword(String password) {
    return password.length >= 8;
  }
}
