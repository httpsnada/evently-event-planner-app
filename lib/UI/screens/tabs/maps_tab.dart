import 'package:evently/UI/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsTab extends StatefulWidget {
  const MapsTab({super.key});

  @override
  State<MapsTab> createState() => _MapsTabState();
}

class _MapsTabState extends State<MapsTab> {
  String? mapStyle;
  late GoogleMapController mapController;
  Location location = Location();
  LatLng? initLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeMap();
    loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: initLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initLocation ?? LatLng(0, 0),
                zoom: 10,
              ),
              style: mapStyle,
              // polylines: {
              //   Polyline(
              //     polylineId: PolylineId("1"),
              //     color: Colors.white,
              //     width: 3,
              //     points: const [
              //       LatLng(26.48675, 31.81507),
              //       LatLng(26.64643, 31.71803),
              //       LatLng(26.59732, 31.59374),
              //     ],
              //   ),
              // },
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(26.59732, 31.59374),
                ),
              },
              myLocationEnabled: true,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
    );
  }

  Future<void> loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map_style/map_style.json',
    );
    setState(() {
      mapStyle = style;
    });
  }

  Future<void> initializeMap() async {
    // 1 - check if location services are enabled
    bool servicesEnabled = await location.serviceEnabled();
    if (!servicesEnabled) {
      servicesEnabled = await location.requestService();
      if (!servicesEnabled) {
        //error dialog
        context.showMessage("Please enable location services");
        return;
      }
    }

    // 2 - check permission states
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.deniedForever) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        //error dialog
        context.showMessage("Please enable location services");
        return;
      }
    }

    // 3 - get user's location
    var locationData = await location.getLocation();
    setState(() {
      initLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }
}
