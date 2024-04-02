import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final getPostProv = context.read<GetPostProvider>();

    Future.microtask(() => getPostProv.getAllPost(context));
    Future.delayed(
      const Duration(milliseconds: 2500),
      () => context.pushReplacementNamed(AppRoute.mainWrapper),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              height: 90,
            ),
            const SizedBox(height: 8),
            Text(
              'Pinjam.co',
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.color.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
