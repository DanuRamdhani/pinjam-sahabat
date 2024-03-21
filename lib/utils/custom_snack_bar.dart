import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, error) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(error.toString()),
    ),
  );
}
