import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontSize: 16, color: MyColor.hitam, fontWeight: FontWeight.bold),
    );
  }
}
