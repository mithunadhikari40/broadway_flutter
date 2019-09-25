import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    var location = new Location();

    location.onLocationChanged().listen((LocationData currentLocation) {
      LatLng latLng =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      print("Curret location is $latLng");
      updateMap(latLng);
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  GoogleMapController _googleMapController;

  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Map demo",
      home: Scaffold(
        body: buildMap(),
        appBar: AppBar(
          title: Text("Map demo"),
        ),
      ),
    );
  }

  Widget buildMap() {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        _googleMapController = controller;
      },
      initialCameraPosition: _initialPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      compassEnabled: true,
      markers: {
        Marker(
          markerId: MarkerId(_initialPosition.toString()),
          position: _initialPosition.target,
        ),
      },
    );
  }

  void updateMap(LatLng latlng) async {
    final CameraPosition position = CameraPosition(
      target: latlng,
      zoom: 16.4746,
    );

    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(position),
    );
    List<Placemark> placemark = 
    await Geolocator().placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    Placemark address= placemark.first;
    print('The current user address is ${address.country} ${address.locality} ${address.subLocality} ');

    setState(() {
      _initialPosition = position;
    });
  }
}
