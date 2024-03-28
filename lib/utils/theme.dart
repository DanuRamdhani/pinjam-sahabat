import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/fonts.dart';

final myTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 58, 199, 164),
    primary: const Color.fromARGB(255, 58, 199, 164),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
  ),
  fontFamily: Fonts.poppins,
  cardTheme: CardTheme(
    color: Colors.grey.shade100,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 58, 199, 164),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
