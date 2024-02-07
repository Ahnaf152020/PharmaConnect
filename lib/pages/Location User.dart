import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationUser extends StatefulWidget {
  @override
  _LocationUserState createState() => _LocationUserState();
}

class _LocationUserState extends State<LocationUser> {
  Position? _currentPosition;
  String _currentAddress = "Address not available";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      setState(() {
        _currentPosition = position;
        if (placemarks.isNotEmpty) {
          Placemark first = placemarks.first;
          _currentAddress =
          "${first.street}, ${first.locality}, ${first.administrativeArea} ${first.postalCode}, ${first.country}";
        }
      });
    } catch (e) {
      print(e);
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
            if (_currentPosition != null)
              Text(
                'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
              ),
            SizedBox(height: 20),
            Text(_currentAddress),
          ],
        ),
      ),
    );
  }
}
