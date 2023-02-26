bool validateMobile(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{7,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (value==null|| value.length == 0 || !regExp.hasMatch(value))
    return false;
  return true;
}

bool validatePassword(String? value) {
  if (value==null|| value.length == 0 || !isStrongPassword(value) || value.contains(" "))
    return false;
  return true;
}


bool validateAmount(String? value) {
  if (value==null || value.length == 0)
    return false;
  return true;
}

bool validateMobile2(String? value) {
  if (value != null) {
    if ((value.length == 9) || (value.length == 10)) {
      if ((value.length == 10) && (value.substring(0, 1) == "0"))
        {
          return true;
        }
      else {
        if (value.length == 9) {
          return true;
        }
        else
          return false;
      }
    }
    else
      return false;
  }
  else
    return false;
}

bool validateName(String? value) {
  if (value==null|| value.length == 0)
    return false;
  return true;
}


bool isStrongPassword(String password)=>(password.length >= 7);

bool isFilled(String? value)=>(value != "");