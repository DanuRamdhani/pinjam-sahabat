import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';

class MySearchDelegate extends SearchDelegate {
  final List<Post> data;

  MySearchDelegate({required this.data});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(FontAwesomeIcons.xmark),
        onPressed: () {
          query = '';
        },
      ),
      const SizedBox(width: 4),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(FontAwesomeIcons.angleLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredData = data
        .where(
          (post) => post.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final post = filteredData[index];
        return ListTile(
          onTap: () {
            context.pushNamed(AppRoute.detailPost, post);
          },
          title: Text(post.title),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredData = query == '' && query.length > 10
        ? data.sublist(0, 10)
        : data
            .where((post) =>
                post.title.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final post = filteredData[index];
        return ListTile(
          onTap: () {
            context.pushNamed(AppRoute.detailPost, post);
          },
          title: Text(post.title),
        );
      },
    );
  }
}
