String? emailValidator(String? value) {
  String? pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp? regex = RegExp(pattern);
  if (value!.isEmpty) return '*Please enter a valid email address.';
  if (!regex.hasMatch(value))
    return '*Please enter a valid email address.';
  else
    return null;
}

String? nameValidator(String? value) {
  String pattern = r'[a-zA-Z]';
  RegExp regex = RegExp(pattern);
  if (value!.isEmpty) return '*Please fill in this required field';
  if (!regex.hasMatch(value))
    return '*Enter a valid name';
  else
    return null;
}
