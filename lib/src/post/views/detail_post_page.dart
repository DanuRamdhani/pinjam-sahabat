import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/post/models/post.dart';
import 'package:pinjam_sahabat/src/post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/post/widgets/google_map_button.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';
import 'package:provider/provider.dart';

class DetailPostPage extends StatelessWidget {
  const DetailPostPage({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: context.width,
                  width: context.width,
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
                        'cache-detail-post',
                        stalePeriod: const Duration(minutes: 30),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: IconButton.filled(
                    onPressed: () => context.pop(),
                    style:
                        IconButton.styleFrom(backgroundColor: Colors.black26),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 4),
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
                        post.rating == 0
                            ? 'Baru'
                            : post.rating.toStringAsFixed(1),
                        style: context.text.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                      onPressed: () {},
                      child: const Text('Booking'),
                    ),
                  ),
                  const Divider(),
                  Text(
                    'Deskripsi barang',
                    style: context.text.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(post.desc),
                  const Divider(),
                  Text(
                    'Lokasi pengambilan barang',
                    style: context.text.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Consumer2<LocationProvider, AddPostProvider>(
                    builder: (context, locProv, addPostProv, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 200,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                post.lat.toDouble(),
                                post.lon.toDouble(),
                              ),
                              zoom: 14,
                            ),
                            onMapCreated: (controller) {
                              locProv.defineMarker(
                                LatLng(
                                  post.lat.toDouble(),
                                  post.lon.toDouble(),
                                ),
                              );
                            },
                            markers: locProv.markers,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GoogleMapButton(
                    lat: post.lat.toDouble(),
                    lon: post.lon.toDouble(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
