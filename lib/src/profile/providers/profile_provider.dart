import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/helper/firebase_helper.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = true;
  Map<String, dynamic>? _userData;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final User? user = FirebaseAuth.instance.currentUser;

    try {
      final DocumentSnapshot snapshot =
          await db.collection('users').doc(user?.uid).get();
      _userData = snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      if (!context.mounted) return;
      customSnackBar(context, 'Error fetching user data');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changeProfilePicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final User? user = FirebaseAuth.instance.currentUser;
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pictures/${user?.uid}');
      await storageRef.putFile(File(pickedFile.path));
      final downloadUrl = await storageRef.getDownloadURL();

      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(user?.uid)
          .update({'profilePicture': downloadUrl});
      if (!context.mounted) return;
      customSnackBar(context, 'Foto profil berhasil diperbarui!');

      await fetchUserData(context);
    }
  }

  Future<void> logout(BuildContext context) async {
    final mainWrapperProv = context.read<MainWrapperProvider>();

    mainWrapperProv.onItemTapped(context, 0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!context.mounted) return;
    context.pushReplacementNamed(AppRoute.login);
  }
}
