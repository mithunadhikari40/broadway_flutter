class ValidationMixing {
  String validateEmail(String value) {
    if (value.contains("@") && value.contains(".")) {
      return null;
    } else {
      return "Invalid email address";
    }
  }

  String validatePassword(String value) {
    if (!(value.length > 4)) {
      return "Password must be at least 5 charactes long";
    }
    return null;
  }
}
