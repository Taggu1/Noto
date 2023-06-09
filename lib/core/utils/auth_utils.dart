import 'package:note_app/core/constants/strings.dart';

String? validatePassword(String? password) {
  // Define your password criteria
  if (password == null) {
    return "Can't be empty";
  }
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  int minPasswordLength = 8;

  // Check if the password meets the criteria
  if (password.length < minPasswordLength) {
    return 'Password must be at least $minPasswordLength characters long.';
  }

  for (int i = 0; i < password.length; i++) {
    if (password[i].toUpperCase() != password[i]) {
      hasLowercase = true;
    }
    if (password[i].toLowerCase() != password[i]) {
      hasUppercase = true;
    }
    if (int.tryParse(password[i]) != null) {
      hasDigits = true;
    }
    if (!password[i].contains(RegExp(r'[a-zA-Z0-9]'))) {
      hasSpecialCharacters = true;
    }
  }

  if (!hasUppercase) {
    return 'Password must contain at least one uppercase letter.';
  }

  if (!hasLowercase) {
    return 'Password must contain at least one lowercase letter.';
  }

  if (!hasDigits) {
    return 'Password must contain at least one digit.';
  }

  if (!hasSpecialCharacters) {
    return 'Password must contain at least one special character.';
  }

  return null; // Password is valid
}

String? validateEmail(String? email) {
  if (email == null) {
    return "Can't be empty";
  }
  // Regular expression pattern for email validation
  String pattern = kEmailPattern;
  RegExp regExp = RegExp(pattern);

  if (!regExp.hasMatch(email)) {
    return 'Invalid email format.';
  }

  return null; // Email is valid
}

String mapErrorCodeToMessage(String code) {
  switch (code) {
    case "AuthException: INVALID_PASSWORD":
      return "Invalid password";
    case "AuthException: TOO_MANY_ATTEMPTS_TRY_LATER":
      return "Too many attempts, Try again later";
    case "AuthException: EMAIL_EXISTS":
      return "Email already exists";
    case "AuthException: EMAIL_NOT_FOUND":
      return "Email doesn't exist";
    default:
      return "Something Went Wrong";
  }
}
