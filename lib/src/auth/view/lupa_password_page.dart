import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';
import 'package:pinjam_sahabat/src/auth/animation/up.dart';
import 'package:pinjam_sahabat/src/auth/provider/login_provider.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_button.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class LupaPasswordPage extends StatelessWidget {
  const LupaPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                FadeInAnimation(
                  delay: 1,
                  child: Center(
                    child: Text(
                      "Lupa Password",
                      style: TextStyle(
                        color: MyColor.hijau,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  onChanged: provider.updateForgotPassword,
                  obsecure: false,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    provider.resetPassword(context);
                  },
                  child: const CustomButton(title: 'Submit'),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    '< Kembali ke Login',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: MyColor.hitam,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
