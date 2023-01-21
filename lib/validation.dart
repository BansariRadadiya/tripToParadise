class Validators {
  String? validateName(String? value, String type) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp =  RegExp(pattern);
    print("Check $value == ${value == null}");
    if (value == null || (value.isEmpty )) {
      return "$type is Required";
    } else if (!regExp.hasMatch(value)) {
      return "$type must be a-z and A-Z";
    }
    return null;
  }

  String? validateRequired(String? value, String type) {
    if (value == null || value.isEmpty) {
      return "$type is Required";
    }
    return null;
  }

  String? validateMobile(String? value) {
    String pattern = r'(^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4,5})$)';
    RegExp regExp =  RegExp(pattern);
    if (value == null) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number is not valid";
    }
    return null;
  }

  //For Email Verification we using RegEx.
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r'^.*(?=.{8,})((?=.*[!@#$%^&*()\-_=+{};:,<.>]){1})(?=.*\d)((?=.*[a-z]){1})((?=.*[A-Z]){1}).*$';
    RegExp regExp =  RegExp(pattern);
    if (value == null) {
      return "Password is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Minimum 8 characters password required with a combination of \n uppercase and lowercase letter and number are required.";
    } else {
      return null;
    }
  }

  String? validatepass(String? value) {
    if (value == null) {
      return 'Please enter Password';
    }
    if (value.length < 9) {
      return 'Must be more than 8 charater';
    } else {
      return null;
    }
  }



  String?  validatedate(String? value) {
    String pattern = r'(^(((0[1-9]|1[0-9]|2[0-8])[\/](0[1-9]|1[012]))|((29|30|31)[\/](0[13578]|1[02]))|((29|30)[\/](0[4,6,9]|11)))[\/](19|[2-9][0-9])\d\d$)|(^29[\/]02[\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)';
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }
}

