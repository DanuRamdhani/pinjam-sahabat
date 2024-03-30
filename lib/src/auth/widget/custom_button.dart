import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';

class CustomButton extends StatelessWidget {
  final String title;

  const CustomButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.hijau,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: Text(
          title,
          style:
              TextStyle(color: MyColor.backgroud, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
