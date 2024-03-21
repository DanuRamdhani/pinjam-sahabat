import 'package:flutter/material.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/main_wrapper/providers/main_wrapper_provider.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainWrapperProvider>(builder: (context, wrapperProv, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: wrapperProv.pages[wrapperProv.selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: context.color.primary,
          unselectedItemColor: context.color.primary.withOpacity(.7),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: wrapperProv.selectedIndex,
          onTap: (index) => wrapperProv.onItemTapped(context, index),
        ),
      );
    });
  }
}
