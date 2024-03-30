import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final String? hintText;
  final bool obsecure;

  const CustomTextField({
    Key? key,
    required this.obsecure,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: MyColor.hitam),
      obscureText: obsecure,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.hitam, width: 2)),
        prefixIconColor: MyColor.hitam,
        hintStyle: TextStyle(color: MyColor.hitam),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: MyColor.hitam,
                size: 30,
              )
            : null,
        hintText: hintText,
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
