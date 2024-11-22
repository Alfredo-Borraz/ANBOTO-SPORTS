abstract class Validations {
  static String? validateEmailOrUsername(String? input) {
    RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    RegExp usernameRegex = RegExp(r"^[a-zA-Z0-9._]+$");

    if (input == null || input.isEmpty) {
      return 'Please enter an email or username';
    } else if (!emailRegex.hasMatch(input) && !usernameRegex.hasMatch(input)) {
      return 'Please enter a valid email or username';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    } else if (!passwordRegex.hasMatch(password)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter a confirm password';
    } else if (confirmPassword != password) {
      return 'password don`t match';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    RegExp egyptPhoneRegex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a phone number';
    } else if (!egyptPhoneRegex.hasMatch(phoneNumber)) {
      return 'Please enter a valid Egyptian phone number';
    }
    return null;
  }

  static String? validateString(String? address) {
    if (address == null || address.isEmpty) {
      return 'Address cannot be empty';
    } else if (address.length < 5) {
      return 'Address must be at least 5 characters long';
    }
    return null;
  }
}
