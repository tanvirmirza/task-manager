import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final FormFieldValidator? validator;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;

  const ProfileTextField(
      {super.key,
      this.validator,
      this.hintText,
      this.textInputAction,
      this.keyboardType,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText!),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.labelLarge,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: obscureText,
        ),
      ],
    );
  }
}
