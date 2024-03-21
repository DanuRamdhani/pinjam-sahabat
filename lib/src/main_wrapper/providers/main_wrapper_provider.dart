import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/src/post/views/add_post_page.dart';
import 'package:pinjam_sahabat/src/post/views/category_page.dart';
import 'package:pinjam_sahabat/src/post/views/home_page.dart';
import 'package:pinjam_sahabat/src/post/views/profile_page.dart';

class MainWrapperProvider extends ChangeNotifier {
  int selectedIndex = 0;

  List pages = const [
    HomePage(),
    CategoryPage(),
    AddPostPage(),
    ProfilePage(),
  ];

  Future<void> onItemTapped(BuildContext context, int index) async {
    selectedIndex = index;
    notifyListeners();
  }
}
