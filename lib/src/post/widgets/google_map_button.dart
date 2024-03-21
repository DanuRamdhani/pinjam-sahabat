// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GoogleMapButton extends StatelessWidget {
  const GoogleMapButton({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  final double lat;
  final double lon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black, side: const BorderSide(width: 2)),
        onPressed: _launchGoogleMaps,
        label: const Text('Open in Google Map'),
        icon: const Icon(Icons.map_outlined),
      ),
    );
  }

  Future<void> _launchGoogleMaps() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
