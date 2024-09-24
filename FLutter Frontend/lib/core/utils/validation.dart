bool isEmailValid(String email) {
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  return emailRegExp.hasMatch(email);
}

bool isPhoneNumberValid(String phoneNumber) {
  final RegExp phoneNumberRegExp = RegExp(
    r'^9\d{9}$',
  );
  return phoneNumberRegExp.hasMatch(phoneNumber);
}

String? validateEmailOrPhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter your email or phone number!';
  } else if (!isEmailValid(value) && !isPhoneNumberValid(value)) {
    return 'Please enter a valid email or a phone number!';
  }
  return null;
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter your email!';
  } else if (!isEmailValid(value)) {
    return 'Please enter a valid email!';
  }
  return null;
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter your phone number!';
  } else if (!isPhoneNumberValid(value)) {
    return 'Please enter a valid phone number!\nEg: 9xxxxxxxxx';
  }
  return null;
}

String? validateFullName(String value) {
  final RegExp nameRegExp = RegExp(
    r'^[A-Z][a-z]*([ ][A-Z][a-z]*)*$',
  );
  if (value.isEmpty) {
    return 'Please enter your full name!';
  } else if (!nameRegExp.hasMatch(value)) {
    return 'Please enter a valid full name!\nEg: Alex Gott';
  }
  return null;
}

String? validateUsername(String value) {
  final RegExp usernameRegExp = RegExp(
    r'^[a-zA-Z0-9]+$',
  );
  if (value.isEmpty) {
    return 'Please enter your username!';
  } else if (!usernameRegExp.hasMatch(value)) {
    return 'Username can only contain alphabets and numbers!';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter your password!';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long!';
  }
  return null;
}

String? validateConfirmPassword(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'Please confirm your password!';
  } else if (password != confirmPassword) {
    return 'Passwords do not match!';
  }
  return null;
}
