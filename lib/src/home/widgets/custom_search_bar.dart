import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      shape: const MaterialStatePropertyAll(StadiumBorder()),
      shadowColor: const MaterialStatePropertyAll(
        Color.fromARGB(40, 0, 0, 0),
      ),
      trailing: const [
        FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          size: 18,
        ),
        SizedBox(width: 8),
      ],
      onTap: () => print('open searh page'),
      hintText: 'Cari barang',
    );
  }
}
