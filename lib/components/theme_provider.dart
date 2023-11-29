import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // ThemeProvider(super.value);

  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleTheme() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    // print("Value is: $themeMode");
    notifyListeners();
  }
}

class MyThemes {
  // In order to the edits made in this class to take effects,
  // we should Restart and not just hot reload.
  //
  // dark
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.purple,
      secondary: Colors.amber,
      background: Colors.black,
      brightness: Brightness.dark,
      outline: Colors.white,
    ),
  );

  // light
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.yellow,
      background: Colors.white,
      outline: Colors.black,
      brightness: Brightness.light,
    ),
  );
}
