import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
);
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
);


class ThemeManager with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
  notifyListeners();
  }
}