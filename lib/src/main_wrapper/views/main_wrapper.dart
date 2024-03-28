import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          unselectedItemColor: context.color.onSurface.withOpacity(.4),
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.boxOpen),
              label: 'Barang',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
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
