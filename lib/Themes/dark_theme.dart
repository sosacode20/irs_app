import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // primarySwatch: Colors.orange,
  appBarTheme: const AppBarTheme(
    // color: Colors.,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  // iconTheme: const IconThemeData(color: Colors.orange),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.orange,
    secondary: Colors.orange,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  useMaterial3: true,
);
