import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final Widget? labelText;
  final String? hintText;
  final String? errorMsg;
  final bool obscureText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.label,
    this.hintText,
    this.errorMsg,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: labelText ?? Text(label ?? ''),
        hintText: hintText,
        errorText: errorMsg,
        errorStyle: const TextStyle(fontSize: 12),
        errorMaxLines: 4,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      initialValue: initialValue,
    );
  }
}
