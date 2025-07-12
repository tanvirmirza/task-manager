import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;

  const AppTextField(
      {super.key,
      this.controller,
      this.textInputAction,
      this.validator,
      this.keyboardType,
      this.onChanged,
      this.inputFormatters,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false, this.border});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: border,
        border: border /// OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      obscureText: obscureText!,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.labelLarge,
      validator: validator,
    );
  }
}
