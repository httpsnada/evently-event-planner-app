import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../database/model/Event.dart';

class MapsTab extends StatefulWidget {
  const MapsTab({Key? key}) : super(key: key);

  @override
  State<MapsTab> createState() => _MapsTabState();
}

class _MapsTabState extends State<MapsTab> {
  GoogleMapController? _controller;
  LatLng? _currentLocation;
  Set<Marker> _markers = {};
  Event? _selectedEvent;
  String? mapStyle;

  @override
  void initState() {
    super.initState();
    _loadEventsAndLocation();
    loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng initialPosition =
    _markers.isNotEmpty && _markers.first.position != null
        ? _markers.first.position
        : (_currentLocation ?? const LatLng(26.55707, 31.68850));

    return Container(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 10,
            ),
            style: mapStyle,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              _controller = controller;
            },
            markers: _markers,
          ),


          if (_selectedEvent != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: 1.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedEvent!.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedEvent = null;
                              });
                            },
                            child: const Text('Close'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          if (_currentLocation == null && _markers.isEmpty)
            const Center(child: CircularProgressIndicator()),
        ],
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

  Future<void> _loadEventsAndLocation() async {
    final location = Location();

    // Request permission and get user location
    PermissionStatus permission = await location.requestPermission();
    if (permission == PermissionStatus.granted) {
      final pos = await location.getLocation();
      setState(() {
        _currentLocation = LatLng(pos.latitude!, pos.longitude!);
      });
    }

    // Fetch events from Firestore
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .get();

    final events = snapshot.docs.map((doc) {
      return Event.fromMap(doc.data());
    }).toList();

    final markers = <Marker>{};
    for (final e in events) {
      if (e.latitude != null && e.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId('1'),
            position: LatLng(e.latitude!, e.longitude!),
            infoWindow: InfoWindow(title: e.title),
            onTap: () {
              setState(() {
                _selectedEvent = e;
              });
            },
          ),
        );
      }
    }

    setState(() {
      _markers = markers;
    });
  }

}



