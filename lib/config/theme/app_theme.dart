import 'dart:math';

import 'package:flutter/material.dart';


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
  'The selected color index must be between 0 y ${_colorsTheme.length - 1}',
  );

  ThemeData theme() {


    final borderInput = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFE0E0E0),
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return ThemeData(
      useMaterial3: true,
      primaryColor: _colorsTheme[selectedColor],
      colorScheme: ColorScheme.fromSeed(seedColor: _colorsTheme[selectedColor]),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: _colorsTheme[selectedColor],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(

          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            _colorsTheme[selectedColor],
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            _colorsTheme[selectedColor],
          ),
          side: WidgetStateProperty.resolveWith<BorderSide>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return BorderSide(
                  color: _colorsTheme[selectedColor].withOpacity(0.5),
                  width: 2,
                );
              }
              return BorderSide(
                color: _colorsTheme[selectedColor],
                width: 2,
              );
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(
            _colorsTheme[selectedColor],
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        enabledBorder: borderInput,
        focusedBorder: borderInput.copyWith(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: _colorsTheme[selectedColor],
          ),
        ),
        focusColor: _colorsTheme[selectedColor],
        labelStyle: const TextStyle(color: Colors.black),
        prefixIconColor: _colorsTheme[selectedColor],
        iconColor: _colorsTheme[selectedColor],
        focusedErrorBorder: borderInput.copyWith(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  return MaterialColor(
    color.value,
    <int, Color>{
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
    },
  );
}

int tintValue(int value, double factor) =>
    max(0, min(value + ((255 - value) * factor).round(), 255));

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

Color randomColor() => _colorsTheme[Random().nextInt(_colorsTheme.length)];
