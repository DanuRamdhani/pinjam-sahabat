import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/routes/routes.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/providers/rent_provider.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/google_map_button.dart';
import 'package:pinjam_sahabat/utils/capitalize_first_letter.dart';
import 'package:pinjam_sahabat/utils/format.dart';
import 'package:provider/provider.dart';

class DetailPostPage extends StatefulWidget {
  const DetailPostPage({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          final rentProv = context.read<RentProvider>();
          rentProv.amount = 1;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Barang'),
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const FaIcon(FontAwesomeIcons.angleLeft),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: context.width,
                width: context.width,
                child: CachedNetworkImage(
                  imageUrl: widget.post.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 1),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  cacheManager: CacheManager(
                    Config(
                      'cache-detail-post',
                      stalePeriod: const Duration(minutes: 30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16).copyWith(bottom: 88),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: widget.post.price == 0
                                ? Colors.red
                                : context.color.primary,
                          ),
                          child: Text(
                            widget.post.price == 0 ? 'gratis' : 'berbayar',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${priceFormated(widget.post.price, false)}/hari',
                          style: context.text.headlineSmall?.copyWith(
                            color: context.color.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          capitalizeFirstLetter(widget.post.title),
                          style: context.text.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star_rate_rounded,
                          color: Colors.yellowAccent.shade700,
                        ),
                        Text(
                          widget.post.rating == 0
                              ? 'Baru'
                              : widget.post.rating.toStringAsFixed(1),
                          style: context.text.bodyMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      'Jumlah barang : ${widget.post.amount}',
                      style: context.text.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text(
                      'Deskripsi barang',
                      style: context.text.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.post.desc),
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
                                  widget.post.lat.toDouble(),
                                  widget.post.lon.toDouble(),
                                ),
                                zoom: 14,
                              ),
                              onMapCreated: (controller) {
                                locProv.defineMarker(
                                  LatLng(
                                    widget.post.lat.toDouble(),
                                    widget.post.lon.toDouble(),
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
                      lat: widget.post.lat.toDouble(),
                      lon: widget.post.lon.toDouble(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          height: 80,
          width: double.infinity,
          child: Consumer<RentProvider>(
            builder: (context, rentProv, _) {
              return Row(
                children: [
                  IconButton.filled(
                    onPressed: () {
                      if (rentProv.amount > 1) {
                        rentProv.decraseAmount();
                      }
                    },
                    icon: const FaIcon(FontAwesomeIcons.minus),
                    padding: const EdgeInsets.all(5),
                    iconSize: 20,
                    visualDensity: const VisualDensity(
                      vertical: -2,
                      horizontal: -2,
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    rentProv.amount.toString(),
                    style: context.text.headlineSmall,
                  ),
                  const SizedBox(width: 16),
                  IconButton.filled(
                    onPressed: () {
                      if (rentProv.amount < widget.post.amount) {
                        rentProv.incraseAmount();
                      }
                    },
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    iconSize: 20,
                    visualDensity: const VisualDensity(
                      vertical: -2,
                      horizontal: -2,
                    ),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        context.pushNamed(AppRoute.detailPayment, widget.post),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32)),
                    child: const Text('Sewa'),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
