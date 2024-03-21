import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/authentication/widgets/form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: FormUser(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
