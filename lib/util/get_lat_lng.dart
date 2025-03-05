import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GetLatLng extends StatefulWidget {
  @override
  _GetLatLngState createState() => _GetLatLngState();
}

class _GetLatLngState extends State<GetLatLng> {
  GoogleMapController? _controller;
  LocationData? _currentLocation;
  final Location _location = Location();
  Marker? _selectedMarker;

  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await _location.getLocation();
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_currentLocation != null) {
      _controller?.animateCamera(CameraUpdate.newLatLng(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
      ));
    }
  }

  void _onTap(LatLng position) {
    setState(() {
      _selectedMarker = Marker(
        markerId: MarkerId('selected_location'),
        position: position,
      );
    });
  }

  void _onSave() {
    if (_selectedMarker != null) {
      Navigator.pop(context, _selectedMarker!.position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentLocation!.latitude!,
                      _currentLocation!.longitude!,
                    ),
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  onTap: _onTap,
                  markers: _selectedMarker != null
                      ? {_selectedMarker!}
                      : Set<Marker>(),
                ),
                if (_selectedMarker != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: _onSave,
                      child: Text('Save Location'),
                    ),
                  ),
              ],
            ),
    );
  }
}
