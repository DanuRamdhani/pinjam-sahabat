import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/authentication/services/auth_service.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';

class AuthenticationProvider extends ChangeNotifier {
  final firebase = FirebaseAuth.instance;
  final form = GlobalKey<FormState>();

  String enteredEmail = '';
  String enteredPassword = '';
  var isAuthenticating = false;
  bool isCantSeePw = true;
  var isLogin = true;

  void changePWVisibility() {
    isCantSeePw = !isCantSeePw;
    notifyListeners();
  }

  void isLoginChange() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void submit(BuildContext context) async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    form.currentState!.save();

    try {
      isAuthenticating = true;
      notifyListeners();

      if (isLogin) {
        AuthService.loginUser(firebase, enteredEmail, enteredPassword);
      } else {
        AuthService.createUser(firebase, enteredEmail, enteredPassword);
      }

      context.pushReplacementNamed(AppRoute.mainWrapper);

      isAuthenticating = false;
      notifyListeners();
    } on FirebaseAuthException catch (error) {
      customSnackBar(context, error);

      isAuthenticating = false;
      notifyListeners();
    }
  }
}
