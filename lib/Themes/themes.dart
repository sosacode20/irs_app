import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IrsFontStyles {
  static const TextStyle headline1 = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 50,
  );
  static const TextStyle headline2 = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 40,
  );
  static const TextStyle headline3 = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 30,
  );
  static const TextStyle headline4 = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 20,
  );
  static const TextStyle normal = TextStyle(
    fontFamily: 'Lexend',
    fontSize: 16,
  );
}

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  // primarySwatch: Colors.orange,
  appBarTheme: const AppBarTheme(
    // color: Colors.,
    // backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  backgroundColor: Colors.grey[800],
  // iconTheme: const IconThemeData(color: Colors.orange),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.orange,
    secondary: Colors.orange,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: 50,
    ),
    headline2: TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: 40,
    ),
    headline3: TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: 30,
    ),
  ),
);

final lightTheme = darkTheme.copyWith(
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  appBarTheme: darkTheme.appBarTheme.copyWith(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  colorScheme: darkTheme.colorScheme.copyWith(
    primary: Colors.blueGrey,
    secondary: Colors.orange,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),
);
