import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? locationLat;
  double? locationLong;
  DateTime? currentTime;

  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    locationData = await location.getLocation();

    if (mounted) {
      setState(() {
        locationLat = locationData.latitude;
        locationLong = locationData.longitude;
        currentTime = DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt());
      });
    }
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latitude : $locationLat"),
            Text("Longitude : $locationLong"),
            Text("Current Time : $currentTime"),
          ],
        ),
      ),
    );
  }
}