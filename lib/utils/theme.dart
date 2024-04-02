import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';
import 'package:pinjam_sahabat/res/fonts.dart';

final myTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: MyColor.hijau,
    primary: MyColor.hijau,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: MyColor.hitam,
    ),
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
  ),
  fontFamily: Fonts.poppins,
  cardTheme: CardTheme(
    color: MyColor.abu,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColor.hijau,
      foregroundColor: MyColor.backgroud,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
