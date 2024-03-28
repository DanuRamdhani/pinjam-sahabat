import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/home/views/home_page.dart';
import 'package:pinjam_sahabat/src/profile/views/profile_page.dart';
import 'package:pinjam_sahabat/src/user_post/views/user_post_page.dart';

class MainWrapperProvider extends ChangeNotifier {
  int selectedIndex = 0;

  List pages = const [
    HomePage(),
    UserPostPage(),
    ProfilePage(),
  ];

  Future<void> onItemTapped(BuildContext context, int index) async {
    selectedIndex = index;
    notifyListeners();
  }
}
