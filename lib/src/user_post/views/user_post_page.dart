import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/widgets/custom_search_bar.dart';
import 'package:provider/provider.dart';

import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/user_post_item.dart';

class UserPostPage extends StatefulWidget {
  const UserPostPage({super.key});

  @override
  State<UserPostPage> createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {
  @override
  void initState() {
    final getUserPost = context.read<GetUserPostProvider>();

    getUserPost.getUserPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(bottom: 0),
          child: Column(
            children: [
              const CustomSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<GetUserPostProvider>(
                  builder: (context, getUserPost, _) {
                    final responseState = getUserPost.responseState;

                    if (responseState == ResponseState.fail) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Something went wrong'),
                            IconButton(
                              onPressed: () => getUserPost.getUserPost(),
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      );
                    }

                    if (responseState == ResponseState.succes) {
                      if (getUserPost.listUserPost.isEmpty) {
                        return const Center(
                          child: Text('Tambah barang yang ingin kamu sewa'),
                        );
                      }

                      return UserPostItem(getUserPost: getUserPost);
                    }

                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      alignment: Alignment.topCenter,
                      child: const CircularProgressIndicator(strokeWidth: 1),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(AppRoute.addPost),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
