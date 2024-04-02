import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';

void customSnackBar(BuildContext context, error) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(error.toString()),
    ),
  );
}

void customErrorSnackBar(BuildContext context, error) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(error.toString()),
      backgroundColor: MyColor.merah,
    ),
  );
}

void customSnackBarwithClose(BuildContext context, error) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(error.toString()),
      action: SnackBarAction(
        label: 'Tutup',
        onPressed: () {},
      ),
    ),
  );
}
