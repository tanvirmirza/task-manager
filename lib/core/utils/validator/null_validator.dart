import 'package:flutter/cupertino.dart';

String? validateNull(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "$value cannot be empty";
  }
  return null;
}


String? validateReferCode(String? value, String title) {
  if (value == null || value.trim().isEmpty) {
    //return "$title cannot be empty";
  }
  return null;
}

String? percentValidator(String? value) {
  int percentage = int.tryParse(value ?? '0') ?? 0;

  if (percentage > 100) {
    return 'Percentage cannot be upper then 100';
  }
  return null;
}
