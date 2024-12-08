import 'package:flutter/material.dart';

class ButtonFill extends StatelessWidget {
  const ButtonFill({
    super.key,
    required this.theme,
    required this.textButton,
    required this.onPressed,
  });

  final ThemeData theme;
  final String textButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(theme.primaryColor),
        ),
        onPressed: onPressed,
        child: Text(textButton, style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
