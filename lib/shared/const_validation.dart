////////////////////////////////
/*
 validation functions
*/
String? validateEmail(String value) {
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (value.isEmpty) {
    return 'حقل البريد الالكتروني فارغ';
  }
  if (!regex.hasMatch(value)) {
    return 'هذا ليس بريد الكتروني صحيح';
  }
  return null;
}

bool validatePassword(String password) {
  // Regular expressions for password validation

  RegExp validationPassword = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  // Checking length
  if (!validationPassword.hasMatch(password)) {
    return false;
  }

  return true;
}

bool validateEgyptianPhoneNumber(String phoneNumber) {
  // Regular expression for Egyptian phone numbers starting with 10, 11, 12, or 15 and having exactly 10 digits
  RegExp regex = RegExp(r"^01[0125]\d{8}$");

  return regex.hasMatch(phoneNumber);
}

String? validateName(String value) {
  RegExp name = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
  if (value.isEmpty) {
    return 'خانة الاسم مطلوبة ';
  }
  if (!name.hasMatch(value)) {
    return 'اسم غير صالح';
  }

  return null;
}
