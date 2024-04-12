class KValidator {
  static String? validateField(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName Required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email Required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Email Wrong';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Passwor Required';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'It Have To Be More Than Six Character';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Add A Capital Letter ';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'A Number Should Be In It';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'A Special Charector Should Be In It';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number Required';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'It Should Be 11 Numbers ';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
