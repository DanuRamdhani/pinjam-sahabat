import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';

class PostCategoryItem extends StatelessWidget {
  const PostCategoryItem({super.key, required this.getPostProv});

  final GetPostProvider getPostProv;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          getPostProv.getPostByCategory(context, getPostProv.selectedCategory),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: context.width * .5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: getPostProv.listPostCategory.length,
        itemBuilder: (context, index) {
          final post = getPostProv.listPostCategory[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: () => context.pushNamed(AppRoute.detailPost, post),
                  child: CachedNetworkImage(
                    imageUrl: post.image,
                    fit: BoxFit.cover,
                    height: context.width * .3,
                    width: context.width * .5,
                    alignment: Alignment.center,
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
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    capitalizeFirstLetter(post.title),
                    style: context.text.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (post.price == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent.shade200,
                      ),
                      child: const Text('gratis'),
                    ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${priceFormated(post.price)}/hari',
                    style: context.text.bodyMedium,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.star_rate_rounded,
                    color: Colors.yellowAccent.shade700,
                  ),
                  Text(
                    post.rating == 0 ? 'Baru' : post.rating.toStringAsFixed(1),
                    style: context.text.bodyMedium,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
