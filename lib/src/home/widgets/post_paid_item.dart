import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';

class PostPaidItem extends StatelessWidget {
  const PostPaidItem({super.key, required this.getPostProv});

  final GetPostProvider getPostProv;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 208,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: getPostProv.listPaidPost.length,
        itemBuilder: (context, index) {
          final post = getPostProv.listPaidPost[index];

          if (index == getPostProv.listPaidPost.length) {
            return const SizedBox(width: 8);
          }

          return GestureDetector(
            onTap: () => context.pushNamed(AppRoute.detailPost, post),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 148,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 116,
                        width: 132,
                        alignment: Alignment.center,
                        imageUrl: post.image,
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child:
                              const CircularProgressIndicator(strokeWidth: 1),
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(priceFormated(post.price, true).toString()),
                        const Spacer(),
                        if (post.rating == 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'baru',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        else
                          Row(
                            children: [
                              Text(
                                post.rating.toStringAsFixed(1),
                              ),
                              const SizedBox(width: 2),
                              FaIcon(
                                FontAwesomeIcons.solidStar,
                                size: 10,
                                color: Colors.yellowAccent.shade700,
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
