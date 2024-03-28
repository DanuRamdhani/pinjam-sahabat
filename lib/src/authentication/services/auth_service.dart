import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';

class AuthService {
  static Future<void> createUser(
    String enteredEmail,
    String enteredPassword,
  ) async {
    final userCrindential = await auth.createUserWithEmailAndPassword(
      email: enteredEmail,
      password: enteredPassword,
    );

    await db.collection('users').doc(userCrindential.user!.uid).set({
      'email': enteredEmail,
      'image_url': 'image_url',
      'createdAt': Timestamp.now(),
    });
  }

  static Future<void> loginUser(
    String enteredEmail,
    String enteredPassword,
  ) async {
    await auth.signInWithEmailAndPassword(
      email: enteredEmail,
      password: enteredPassword,
    );
  }
}
