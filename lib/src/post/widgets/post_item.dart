import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/post/providers/get_post.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.scrollController,
    required this.getPostProv,
  });

  final ScrollController scrollController;
  final GetPostProvider getPostProv;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getPostProv.refreshPost(context),
      child: ListView.builder(
        controller: scrollController,
        itemCount: getPostProv.listPost.length +
            (getPostProv.resultLenght == 0 ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == getPostProv.listPost.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            );
          }

          if (getPostProv.listPost.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }

          final post = getPostProv.listPost[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: context.width * .5,
                  width: context.width,
                  child: GestureDetector(
                    onTap: () => context.pushNamed(AppRoute.detailPost, post),
                    child: CachedNetworkImage(
                      imageUrl: post.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(strokeWidth: 1),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      cacheManager: CacheManager(
                        Config(
                          'cache-post',
                          stalePeriod: const Duration(minutes: 30),
                        ),
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
                      fontSize: 18,
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
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
