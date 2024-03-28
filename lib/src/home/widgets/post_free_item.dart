import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';

class PostFreeItem extends StatelessWidget {
  const PostFreeItem({super.key, required this.getPostProv});

  final GetPostProvider getPostProv;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: getPostProv.listFreePost.length,
        itemBuilder: (context, index) {
          final post = getPostProv.listFreePost[index];

          return SizedBox(
            width: 140,
            child: GestureDetector(
              onTap: () => context.pushNamed(AppRoute.detailPost, post),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 140,
                      width: 140,
                      alignment: Alignment.center,
                      imageUrl: post.image,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(strokeWidth: 1),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      cacheManager: CacheManager(
                        Config(
                          'cache-post-category',
                          stalePeriod: const Duration(minutes: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    capitalizeFirstLetter(post.title),
                    style: context.text.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    post.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
