import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const ProfileTextField({
    super.key,
    this.hintText,
    this.textInputAction,
    this.keyboardType,
  });

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
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.labelLarge,
          decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}