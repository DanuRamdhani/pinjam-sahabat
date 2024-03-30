import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/res/color.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/auth/animation/up.dart';
import 'package:pinjam_sahabat/src/auth/provider/login_provider.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_button.dart';
import 'package:pinjam_sahabat/src/auth/widget/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: MyColor.backgroud,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    FadeInAnimation(
                      delay: 1,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: MyColor.hijau,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextField(
                      onChanged: provider.updateEmail,
                      obsecure: false,
                      hintText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      obsecure: true,
                      hintText: 'Password',
                      onChanged: provider.updatePassword,
                      prefixIcon: Icons.lock,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => context.pushReplacementNamed(AppRoute.forgotPassword),
                      child: Text(
                        'Lupa Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColor.hitam,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColor.hitam,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () => provider.login(context),
                      child: const CustomButton(title: 'Login'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account yet? ",
                          style: TextStyle(color: MyColor.hitam),
                        ),
                        InkWell(
                          onTap: () {
                            context.pushReplacementNamed(AppRoute.registration);
                          },
                          child: Text(
                            "Register now!",
                            style: TextStyle(color: MyColor.hijau),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
