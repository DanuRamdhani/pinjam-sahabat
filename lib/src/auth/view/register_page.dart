import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/res/color.dart';
import 'package:pinjam_sahabat/src/auth/animation/up.dart';
import 'package:pinjam_sahabat/src/auth/provider/regis_provider.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_button.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      backgroundColor: MyColor.backgroud,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                FadeInAnimation(
                  delay: 1,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: MyColor.hijau,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: 'Username',
                  onChanged: provider.updateUsername,
                  prefixIcon: Icons.person,
                  obsecure: false,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  obsecure: false,
                  hintText: 'Email',
                  onChanged: provider.updateEmail,
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  obsecure: true,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  onChanged: provider.updatePassword,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  onChanged: provider.updatePhoneNumber,
                  obsecure: false,
                  hintText: 'No Telp',
                  prefixIcon: Icons.phone,
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    const username = '';
                    const phoneNumber = '';
                    provider.register(context, username, phoneNumber);
                  },
                  child: const CustomButton(title: 'Register'),
                ),
                const SizedBox(height: 10),
                _LoginText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an account?",
          style: TextStyle(color: MyColor.hitam),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text(
            " Login",
            style: TextStyle(color: MyColor.hijau),
          ),
        )
      ],
    );
  }
}
