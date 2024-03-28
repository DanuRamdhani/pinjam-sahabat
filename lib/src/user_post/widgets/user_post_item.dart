import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/user_post/providers/get_user_post_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/delete_post_dialog.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';

class UserPostItem extends StatelessWidget {
  const UserPostItem({super.key, required this.getUserPost});

  final GetUserPostProvider getUserPost;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: getUserPost.listUserPost.length,
      itemBuilder: (context, index) {
        final userPost = getUserPost.listUserPost[index];

        if (index == getUserPost.listUserPost.length) {
          return const SizedBox(height: 80);
        }

        return GestureDetector(
          onTap: () => context.pushNamed(AppRoute.detailUserPost, userPost),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      imageUrl: userPost.image,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      cacheManager: CacheManager(
                        Config(
                          'cache-user-post',
                          stalePeriod: const Duration(minutes: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizeFirstLetter(userPost.title),
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          priceFormated(userPost.price, true),
                          style: context.text.headlineSmall?.copyWith(
                            color: context.color.primary,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () =>
                                context.pushNamed(AppRoute.editPost, userPost),
                            icon: const FaIcon(FontAwesomeIcons.penToSquare),
                            iconSize: 20,
                          ),
                          IconButton(
                            onPressed: () =>
                                deletePostDialog(context, userPost.postId!),
                            icon: const FaIcon(FontAwesomeIcons.trashCan),
                            iconSize: 20,
                          ),
                        ],
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'Jumlah :',
                          children: [
                            TextSpan(
                              text: '14',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => context.pushNamed(AppRoute.rentUser, userPost),
                child: const Text('daftar pemesan'),
              ),
            ],
          ),
        );
      },
    );
  }
}
