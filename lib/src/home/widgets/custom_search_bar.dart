import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/widgets/my_search_delegate.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.listPost});

  final List<Post> listPost;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      shape: const MaterialStatePropertyAll(StadiumBorder()),
      shadowColor: const MaterialStatePropertyAll(
        Color.fromARGB(40, 0, 0, 0),
      ),
      trailing: const [
        FaIcon(FontAwesomeIcons.magnifyingGlass, size: 18),
        SizedBox(width: 8),
      ],
      onTap: () {
        showSearch(
          context: context,
          delegate: MySearchDelegate(data: widget.listPost),
        );
      },
      hintText: 'Cari barang',
      focusNode: _focusNode,
    );
  }
}
