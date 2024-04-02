import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
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
  }

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        await saveLoginData(user);
        if (!context.mounted) return;
        context.pushReplacementNamed(AppRoute.splash);
        clearCredentials();
      } else if (user != null && !user.emailVerified) {
        if (!context.mounted) return;
        customSnackBar(context, 'Please verify your email before logging in.');
      } else {
        if (!context.mounted) return;
        customSnackBar(context, 'Invalid email or password.');
      }
    } catch (e) {
      customSnackBar(context, 'An error occurred. Please try again later.');
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: _forgotPassword);
      if (!context.mounted) return;
      customSnackBarwithClose(
        context,
        'Email untuk reset password telah dikirim.',
      );

      context.pushReplacementNamed(AppRoute.login);
      clearCredentials();
    } catch (e) {
      customSnackBarwithClose(
        context,
        'Gagal mengirim email reset password. Periksa kembali email Anda.',
      );
    }
  }
}
