import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSelectPage extends StatefulWidget {
  const MapSelectPage({Key? key}) : super(key: key);

  @override
  _MapSelectPageState createState() => _MapSelectPageState();
}

class _MapSelectPageState extends State<MapSelectPage> {
  GoogleMapController? _controller;
  LatLng? _picked;
  LatLng _initial = LatLng(26.55707, 31.68850);
  String? mapStyle;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
    loadMapStyle();
  }

  void _onTap(LatLng pos) {
    setState(() => _picked = pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select event location'),
        actions: [
          TextButton(
            onPressed: _picked == null
                ? null
                : () => Navigator.pop(context, _picked),
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initial, zoom: 14),
            style: mapStyle,
            myLocationEnabled: true,
            onMapCreated: (c) => _controller = c,
            onTap: _onTap,
            markers: _picked == null
                ? {}
                : {Marker(markerId: MarkerId('picked'), position: _picked!)},
          ),

          // show coordinates + confirm button when a location is picked
          if (_picked != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Picked: ${_picked!.latitude.toStringAsFixed(6)}, ${_picked!.longitude.toStringAsFixed(6)}',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, _picked);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                        ),
                        child: const Text('Confirm location'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _setCurrentLocation() async {
    final loc = Location();
    try {
      final permission = await loc.requestPermission();
      if (permission == PermissionStatus.granted) {
        final pos = await loc.getLocation();
        setState(() {
          _initial = LatLng(pos.latitude!, pos.longitude!);
        });
        _controller?.animateCamera(CameraUpdate.newLatLngZoom(_initial, 16));
      }
    } catch (e) {}
  }

  Future<void> loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map_style/map_style.json',
    );
    setState(() {
      mapStyle = style;
    });
  }
}
