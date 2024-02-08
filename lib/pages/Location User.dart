import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationUser extends StatefulWidget {
  @override
  _LocationUserState createState() => _LocationUserState();
}

class _LocationUserState extends State<LocationUser> {
  String locationMessage = 'Current Location Of The User';
  String lat = 'N/A';
  String long = 'N/A';

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw ('Location services are Disabled');
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw ('Location permissions are denied ');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw ('Location Permissions Are Permanently Denied');
      }

      Position value = await Geolocator.getCurrentPosition();
      lat = value.latitude.toString();
      long = value.longitude.toString();
      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $long';
      });
      _liveLocation();
    } catch (e) {
      print('Error getting location: $e');
      // Handle the error as needed
      // You might want to show a message to the user or take other actions
    }
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $long';
      });
    });
  }

  Future<void> _openMap(String? lat, String? long) async {
    if (lat != null && long != null && lat != 'N/A' && long != 'N/A' ){
      String googleURL = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      await canLaunch(googleURL)
          ? await launch(googleURL)
          : throw 'Could not launch $googleURL';
    } else {
      print('Latitude or longitude is null. Cannot open map.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(locationMessage, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _getCurrentLocation();
              },
              child: const Text('Get Current Location'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openMap(lat, long);
              },
              child: const Text('Open Google Map'),
            ),
          ],
        ),
      ),
    );
  }
}
