import 'package:flutter/cupertino.dart';

class FormValidation {
  /// Validate email format and emptiness
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value.trim())) {
      return "Please enter a valid email";
    }
    return null;
  }

  /// Validate phone number (10-15 digits, optional leading +)
  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    const phonePattern = r'^\+?[0-9]{10,15}$';
    final regex = RegExp(phonePattern);
    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Validate password complexity requirements
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain at least one special character (e.g., !@#\$&*~)';
    }
    return null;
  }

  /// Validate 4-digit PIN only numeric
  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN cannot be empty';
    }
    if (value.length != 4) {
      return 'PIN must be exactly 4 digits';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }
    return null;
  }

  /// Validate name for minimum length and emptiness
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Generic null/empty validation
  String? validateNull(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  /// Validate password match with a controller's value
  String? validatePasswordMatch(
      String? value,
      TextEditingController passwordController,
      ) {
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  /// Validator for confirming a new password with stricter rules
  String? confirmPasswordValidator(
      String? value,
      TextEditingController originalPasswordController,
      ) {
    if (value == null || value.isEmpty) {
      return "Must be at least 8 characters";
    }
    if (value.length < 8) {
      return "Must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain at least one uppercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain at least one number";
    }
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Must contain at least one special character";
    }
    if (value != originalPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
