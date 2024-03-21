import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/authentication/providers/auth.dart';
import 'package:provider/provider.dart';

class FormUser extends StatelessWidget {
  const FormUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (context, authProv, _) {
      return Form(
        key: authProv.form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Addres',
                isDense: true,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Please enter a valid email addres.';
                }

                return null;
              },
              onSaved: (newValue) {
                authProv.enteredEmail = newValue!;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                isDense: true,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => authProv.changePWVisibility(),
                  icon: const Icon(Icons.remove_red_eye_rounded),
                ),
              ),
              obscureText: authProv.isCantSeePw,
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Password must be at least 6 characters long.';
                }

                return null;
              },
              onSaved: (newValue) {
                authProv.enteredPassword = newValue!;
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => authProv.submit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: authProv.isAuthenticating
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : Text(authProv.isLogin ? 'Log in' : 'Sign up'),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  authProv.isLogin
                      ? 'Create an account!'
                      : 'Already have an account?',
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: authProv.isLoginChange,
                  child: Text(
                    authProv.isLogin ? 'Signup' : 'Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }
}
