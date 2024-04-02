import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/home/providers/get_post.dart';
import 'package:pinjam_sahabat/src/home/widgets/custom_search_bar.dart';
import 'package:pinjam_sahabat/src/profile/providers/profile_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/category_menu.dart';
import 'package:pinjam_sahabat/src/home/widgets/post_free_item.dart';
import 'package:pinjam_sahabat/src/home/widgets/post_paid_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getPostProv = context.read<GetPostProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Consumer<ProfileProvider>(
          builder: (context, profileProv, _) {
            final Map<String, dynamic>? data = profileProv.userData;

            if (data?['profilePicture'] != null) {
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      imageUrl: data?['profilePicture'],
                      placeholder: (context, url) => FaIcon(
                        FontAwesomeIcons.solidCircleUser,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                      errorWidget: (context, url, error) => FaIcon(
                        FontAwesomeIcons.solidCircleUser,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                      cacheManager: CacheManager(
                        Config(
                          'cache-profile',
                          stalePeriod: const Duration(minutes: 30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Halo, ${data?['username']}',
                    style: context.text.titleMedium,
                  ),
                ],
              );
            }

            return Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: FaIcon(
                    FontAwesomeIcons.solidCircleUser,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'anonymous',
                  style: context.text.titleMedium,
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16).copyWith(top: 4),
            child: CustomSearchBar(
              listPost: getPostProv.listAllPost,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(left: 16),
              children: [
                const CategoryMenu(),
                const SizedBox(height: 16),
                Consumer<GetPostProvider>(
                  builder: (context, getPostProv, _) {
                    final responseState = getPostProv.responseState;

                    if (responseState == ResponseState.fail) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Something went wrong'),
                            IconButton(
                              onPressed: () => getPostProv.refreshPost(context),
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      );
                    }

                    if (responseState == ResponseState.succes) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Barang Gratis',
                            style: context.text.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          PostFreeItem(getPostProv: getPostProv),
                          const SizedBox(height: 24),
                          Text(
                            'Barang Sewaan',
                            style: context.text.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          PostPaidItem(getPostProv: getPostProv),
                        ],
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(top: 16),
                      alignment: Alignment.topCenter,
                      child: const CircularProgressIndicator(strokeWidth: 1),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
