import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';

class RegistrationProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _username = '';
  String _phoneNumber = '';

  void updateUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> register(
    BuildContext context,
    String username,
    String phoneNumber,
  ) async {
    try {
      if (username.trim().isEmpty || phoneNumber.trim().isEmpty) {
        customErrorSnackBar(context, 'lengkapi semua form');
        return;
      } else {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        await userCredential.user?.sendEmailVerification();

        await db.collection('users').doc(userCredential.user?.uid).set({
          'username': _username,
          'email': _email,
          'phoneNumber': _phoneNumber,
          'createdAt': Timestamp.now(),
          'profilePicture': null,
        });

        if (!context.mounted) return;
        customSnackBar(
          context,
          'A verification email has been sent to ${userCredential.user?.email}. '
          'Please verify your email before logging in.',
        );

        context.pushReplacementNamed(AppRoute.login);
      }
    } catch (e) {
      customSnackBarwithClose(
        context,
        'Registration failed. Please try again!',
      );
    }
  }
}
