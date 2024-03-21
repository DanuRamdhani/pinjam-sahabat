import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinjam_sahabat/src/post/models/response.dart';
import 'package:pinjam_sahabat/utils/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier {
  late GoogleMapController mapController;
  LatLng initialLoc = const LatLng(-6.8957473, 107.6337669);

  final Set<Marker> markers = {};
  MapType selectedMapType = MapType.normal;
  ResponseStateGoogleMap response = ResponseStateGoogleMap.initial;

  geo.Placemark? placemark;
  String street = '';
  String address = '';
  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  Future<void> onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    mapController = controller;
    notifyListeners();
    await getMyLocation(context, mapController);
  }

  void defineMarker(LatLng latLng, [String? street, String? address]) {
    markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId('your-loc'),
          position: latLng,
          infoWindow: InfoWindow(
            title: street,
            snippet: address,
          ),
        ),
      );
    notifyListeners();
  }

  Future<void> getMyLocation(
    BuildContext context,
    GoogleMapController mapController,
  ) async {
    final locProv = context.read<LocationProvider>();
    final location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (!context.mounted) return;
        customSnackBar(context, 'Location services is not available');
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (!context.mounted) return;
        customSnackBar(context, 'Location permission is denied');
        return;
      }
    }

    response = ResponseStateGoogleMap.loading;
    notifyListeners();

    try {
      locationData = await location.getLocation();

      locProv.initialLoc =
          LatLng(locationData.latitude!, locationData.longitude!);
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);
      final info =
          await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final place = info[0];
      street = place.street!;
      address = '${place.subLocality}, ${place.locality}, '
          '${place.postalCode}, ${place.country}';
      placemark = place;

      defineMarker(latLng, street, address);
      await mapController.animateCamera(
        CameraUpdate.newLatLng(latLng),
      );
    } catch (e) {
      if (!context.mounted) return;
      customSnackBar(context, 'Gagal mengambil lokasi! Cek koneksi internet');
    }

    response = ResponseStateGoogleMap.succes;
    notifyListeners();
    return;
  }

  Future<void> onTapMap(
    BuildContext context,
    LatLng latLng,
  ) async {
    final locProv = context.read<LocationProvider>();

    try {
      final info =
          await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final place = info[0];
      final street = place.street!;
      address = '${place.subLocality}, ${place.locality}, '
          '${place.postalCode}, ${place.country}';

      placemark = place;
      notifyListeners();

      locProv.initialLoc = LatLng(latLng.latitude, latLng.longitude);
      debugPrint(locProv.initialLoc.toString());

      defineMarker(latLng, street, address);

      await mapController.animateCamera(
        CameraUpdate.newLatLng(latLng),
      );
    } catch (e) {
      if (!context.mounted) return;
      customSnackBar(context, 'Gagal mengambil lokasi! Cek koneksi internet');
    }
  }
}
