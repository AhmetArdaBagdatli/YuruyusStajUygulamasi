import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class RecordMap extends StatefulWidget {
  final bool isRecording;
  final Function(double) onDistanceUpdate;

  const RecordMap({
    Key? key,
    required this.isRecording,
    required this.onDistanceUpdate,
  }) : super(key: key);

  @override
  State<RecordMap> createState() => _RecordMapState();
}

class _RecordMapState extends State<RecordMap> {
  LatLng? _currentP;
  Location _location = Location();
  Map<PolylineId, Polyline> _polylines = {};
  List<LatLng> _recordedPath = [];
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeLocationService();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(RecordMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _startRecording();
      } else {
        _stopRecording();
      }
    }
  }

  Future<void> _initializeLocationService() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationSubscription = _location.onLocationChanged.listen(_updateLocation);
  }

  void _updateLocation(LocationData currentLocation) {
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      setState(() {
        _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
      _updateCameraPosition(_currentP!);
      if (widget.isRecording) {
        _recordedPath.add(_currentP!);
        _updatePolyline();
        _updateDistance();
      }
    }
  }

  void _startRecording() {
    _recordedPath.clear();
    if (_currentP != null) {
      _recordedPath.add(_currentP!);
    }
  }

  void _stopRecording() {
    // Optionally, you can save the recorded path or perform other actions here
  }

  void _updatePolyline() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: _recordedPath,
      width: 5,
    );
    setState(() {
      _polylines[id] = polyline;
    });
  }

  void _updateDistance() {
    if (_recordedPath.length >= 2) {
      double distance = _calculateDistance(_recordedPath);
      widget.onDistanceUpdate(distance);
    }
  }

  double _calculateDistance(List<LatLng> path) {
    double totalDistance = 0.0;
  
    for (int i = 0; i < path.length - 1; i++) {
      totalDistance += Geolocator.distanceBetween(
        path[i].latitude,
        path[i].longitude,
        path[i + 1].latitude,
        path[i + 1].longitude,
      );
    }
    return totalDistance / 1000;
  }

  Future<void> _updateCameraPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newPos = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newPos));
  }

  @override
  Widget build(BuildContext context) {
    return _currentP == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: CameraPosition(target: _currentP!, zoom: 16),
            markers: {
              Marker(
                markerId: MarkerId('_currentlocation'),
                icon: BitmapDescriptor.defaultMarker,
                position: _currentP!,
              ),
            },
            polylines: Set<Polyline>.of(_polylines.values),
          );
  }
}