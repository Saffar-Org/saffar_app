/// Handles validation
class ValidatorService {
  /// Validates if name contains atleast 1 character
  bool validateName(String name) {
    return name.isNotEmpty;
  }

  /// Validates is phone is Numeric and contains 10
  /// digits
  bool validatePhone(String phone) {
    if (phone.length != 10) {
      return false;
    }

    final int? phoneInNumeric = int.tryParse(phone);

    if (phoneInNumeric == null) {
      return false;
    }

    return true;
  }

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
