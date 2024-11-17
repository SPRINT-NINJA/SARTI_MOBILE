import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF578FF5);
const List<Color> _colorsTheme = [
  _customColor,
  Colors.white,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.brown,
  Colors.grey,
  Colors.teal,
  Colors.cyan,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorsTheme.length,
            'Invalid color index'
            'The selected color index must be between 0 and ${_colorsTheme.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorsTheme[selectedColor],
    );
  }
}
