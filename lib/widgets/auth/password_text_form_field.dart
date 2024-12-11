import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String? label;
  final Widget? labelText;
  final String? hintText;
  final String? errorMsg;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const PasswordTextFormField({
    super.key,
    this.labelText,
    this.label,
    this.hintText,
    this.errorMsg,
    this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: widget.labelText ?? Text(widget.label ?? ''),
        hintText: widget.hintText,
        errorText: widget.errorMsg,
        errorStyle: const TextStyle(fontSize: 12),
        errorMaxLines: 4,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleObscureText,
        ),
      ),
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      initialValue: widget.initialValue,
    );
  }
}
