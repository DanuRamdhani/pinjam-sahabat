import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

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
      BuildContext context, String username, String phoneNumber) async {
    try {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'A verification email has been sent to ${userCredential.user?.email}. Please verify your email before logging in.'),
        ),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registration failed. Please try again!'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        ),
      );

      print("Error: $e");
    }
  }
}
