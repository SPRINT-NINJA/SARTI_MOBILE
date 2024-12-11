import 'package:flutter/material.dart';

class ButtonFillIcon extends StatelessWidget {
  const ButtonFillIcon({
    super.key,
    required this.theme,
    required this.textButton,
    required this.onPressed,
    this.icon = Icons.arrow_forward,
    this.iconAlignment = IconAlignment.end,
  });

  final ThemeData theme;
  final String textButton;
  final VoidCallback onPressed;
  final IconData icon;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: FilledButton.icon(
        iconAlignment: iconAlignment,
        icon: Icon(icon),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(theme.primaryColor),
        ),
        onPressed: onPressed,
        label: Text(textButton, style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
