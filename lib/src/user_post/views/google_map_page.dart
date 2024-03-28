import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/home/models/post.dart';
import 'package:pinjam_sahabat/src/home/models/response.dart';
import 'package:pinjam_sahabat/src/user_post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/user_post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/user_post/widgets/place_mark.dart';
import 'package:provider/provider.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key, this.post});

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<LocationProvider>(
          builder: (context, locProv, _) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: locProv.initialLoc,
                    zoom: 16,
                  ),
                  onMapCreated: (controller) {
                    if (post == null) {
                      locProv.onMapCreated(context, controller);
                    } else {
                      locProv.onEditMapCreated(
                        context,
                        controller,
                        LatLng(post?.lat as double, post?.lon as double),
                      );
                    }
                  },
                  markers: locProv.markers,
                  mapType: locProv.selectedMapType,
                  zoomControlsEnabled: false,
                  onTap: (latlng) => locProv.onTapMap(context, latlng),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton.small(
                        heroTag: 'back',
                        onPressed: () => context.pop(),
                        child: const Icon(FontAwesomeIcons.angleLeft),
                      ),
                      FloatingActionButton.small(
                        heroTag: 'your-location',
                        onPressed: () {
                          locProv.getMyLocation(context, locProv.mapController);
                        },
                        child: const Icon(Icons.my_location),
                      ),
                    ],
                  ),
                ),
                if (locProv.placemark != null)
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Consumer<AddPostProvider>(
                          builder: (context, addPostProv, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.color.primaryContainer,
                                foregroundColor:
                                    context.color.onPrimaryContainer,
                              ),
                              onPressed: () {
                                addPostProv.addLocation(context);
                                context.pop();
                              },
                              child: const Text('Tambah'),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Placemark(
                          placemark: locProv.placemark!,
                        ),
                      ],
                    ),
                  ),
                if (locProv.response == ResponseState.loading)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.color.onPrimary,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
