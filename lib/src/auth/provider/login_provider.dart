// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _forgotPassword = '';

  String get email => _email;
  String get password => _password;
  String get forgotPassword => _forgotPassword;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateForgotPassword(String value) {
    _forgotPassword = value;
    notifyListeners();
  }

  void clearCredentials() {
    _email = '';
    _password = '';
    _forgotPassword = '';
    notifyListeners();
  }

  Future<void> saveLoginData(User? user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', user?.email ?? '');
    // Tambahkan informasi lain yang ingin Anda simpan dari user
  }

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        await saveLoginData(user); // Simpan data login
        context.pushReplacementNamed(AppRoute.splash);
        clearCredentials(); // Clear credentials after successful login
      } else if (user != null && !user.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your email before logging in.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: _forgotPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Email untuk reset password telah dikirim.'),
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {},
          ),
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
      clearCredentials();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Gagal mengirim email reset password. Periksa kembali email Anda.'),
          action: SnackBarAction(
            label: 'Tutup',
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
