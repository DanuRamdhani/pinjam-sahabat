import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<void> createUser(
    FirebaseAuth firebase,
    String enteredEmail,
    String enteredPassword,
  ) async {
    final userCrindential = await firebase.createUserWithEmailAndPassword(
      email: enteredEmail,
      password: enteredPassword,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCrindential.user!.uid)
        .set({
      'email': enteredEmail,
      'image_url': 'image_url',
      'createdAt': Timestamp.now(),
    });
  }

  static Future<void> loginUser(
    FirebaseAuth firebase,
    String enteredEmail,
    String enteredPassword,
  ) async {
    await firebase.signInWithEmailAndPassword(
      email: enteredEmail,
      password: enteredPassword,
    );
  }
}
