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
    colorScheme: ColorScheme.dark(
      primary: Colors.orange,
      secondary: Colors.blue,
      background: Colors.black,
      brightness: Brightness.dark,
      outline: Colors.white,
      surface: Colors.grey.shade900,
    ),
    fontFamily: 'Quicksand',
  );

  // light
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.purple,
      secondary: Colors.orangeAccent,
      background: Colors.white,
      outline: Colors.black,
      brightness: Brightness.light,
      surface: Colors.white,
      onSurface: Colors.black,
      onPrimary: Colors.white,
    ),
    // Setting the font family of this ThemeData
    fontFamily: 'Quicksand',
    // Setting the title theme from ThemeData default of flutter
    textTheme: ThemeData.light().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
  );
}
