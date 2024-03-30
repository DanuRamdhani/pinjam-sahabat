import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        child: Icon(
          FontAwesomeIcons.truckRampBox,
          size: 72,
          color: context.color.primary,
        ),
      ),
    );
  }
}
