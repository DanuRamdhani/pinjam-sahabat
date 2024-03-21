import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/extensions/context_extension.dart';
import 'package:pinjam_sahabat/src/post/models/response.dart';
import 'package:pinjam_sahabat/src/post/providers/add_post.dart';
import 'package:pinjam_sahabat/src/post/providers/location_provider.dart';
import 'package:pinjam_sahabat/src/post/widgets/place_mark.dart';
import 'package:provider/provider.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key});

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
                    locProv.onMapCreated(context, controller);
                  },
                  markers: locProv.markers,
                  mapType: locProv.selectedMapType,
                  zoomControlsEnabled: false,
                  onTap: (latlng) => locProv.onTapMap(context, latlng),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: FloatingActionButton.small(
                    heroTag: 'back',
                    backgroundColor:
                        context.color.primaryContainer.withOpacity(.5),
                    onPressed: () => context.pop(),
                    child: const Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(
                    children: [
                      FloatingActionButton.small(
                        heroTag: 'your-location',
                        onPressed: () {
                          locProv.getMyLocation(context, locProv.mapController);
                        },
                        child: const Icon(Icons.my_location),
                      ),
                      Consumer<AddPostProvider>(
                        builder: (context, addPostProv, _) {
                          return FloatingActionButton.small(
                            backgroundColor:
                                const Color.fromARGB(255, 83, 238, 163),
                            foregroundColor: Colors.black,
                            heroTag: 'add-loc',
                            onPressed: () {
                              addPostProv.addLocation(context);
                              context.pop();
                            },
                            child: const Icon(Icons.add_location_alt_outlined),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (locProv.placemark != null)
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Placemark(
                      placemark: locProv.placemark!,
                    ),
                  ),
                if (locProv.response == ResponseStateGoogleMap.loading)
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
