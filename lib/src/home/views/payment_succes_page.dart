import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';

class PaymentSuccesPage extends StatefulWidget {
  const PaymentSuccesPage({super.key});

  @override
  State<PaymentSuccesPage> createState() => _PaymentSuccesPageState();
}

class _PaymentSuccesPageState extends State<PaymentSuccesPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).popUntil(
          (route) => route.settings.name == AppRoute.mainWrapper,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Berhasil Menyewa Barang',
                style: context.text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                color: context.color.primary,
                size: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
