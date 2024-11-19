import 'dart:math';

import 'package:flutter/material.dart';

const Color _primaryColor = Color.fromRGBO(248, 151, 50, 1);


const List<Color> _colorsTheme = [
  _primaryColor,
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
      : assert(
          selectedColor >= 0 && selectedColor < _colorsTheme.length,
          'The selected color index must be between 0 and ${_colorsTheme.length - 1}',
        );

  ThemeData theme() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _primaryColor, width: 2,),
        ),
        labelStyle: TextStyle(color: Colors.black),
      ),
      useMaterial3: true,
      primarySwatch: createMaterialColor(_colorsTheme[selectedColor]),
      primaryColor: _colorsTheme[selectedColor],
      appBarTheme: const AppBarTheme(
        backgroundColor: _primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


MaterialColor createMaterialColor(Color color){
  return MaterialColor(color.value, <int, Color>{
    50: color.withOpacity(0.1),
    100: color.withOpacity(0.2),
    200: color.withOpacity(0.3),
    300: color.withOpacity(0.4),
    400: color.withOpacity(0.5),
    500: color.withOpacity(0.6),
    600: color.withOpacity(0.7),
    700: color.withOpacity(0.8),
    800: color.withOpacity(0.9),
    900: color.withOpacity(1),
  });

}

int tintValue(int value, double factor) => max(0, min(value + ((255 - value) * factor).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
  tintValue(color.red, factor),
  tintValue(color.green, factor),
  tintValue(color.blue, factor),
  1,
);

Color shadeColor(Color color, double factor) => Color.fromRGBO(
  (color.red * factor).round(),
  (color.green * factor).round(),
  (color.blue * factor).round(),
  1,
);




