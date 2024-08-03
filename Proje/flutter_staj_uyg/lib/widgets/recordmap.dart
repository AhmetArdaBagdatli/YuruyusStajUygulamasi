import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LatLng? _currentP;
  Location _location = Location();
  Map<PolylineId, Polyline> _polylines = {};
  List<LatLng> _recordedPath = [];
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;
  DateTime? _start;
  final List<String> days = ["Paz", "Pzt", "Sal", "Çar", "Per", "Cum", "Cmt"];

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
    _start = Timestamp.now().toDate();
    _recordedPath.clear();
    if (_currentP != null) {
      _recordedPath.add(_currentP!);
    }
  }

  void _stopRecording() async {
      User? user = _auth.currentUser;
      DateTime _end = Timestamp.now().toDate();

      Duration duration = _end.difference(_start!);
      int dhours = duration.inHours;
      int dminutes = duration.inMinutes % (60);
    if (user != null) {
      List<Map<String, double>> serializedRoute = _recordedPath.map((latLng) => {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      }).toList();

      await _firestore.collection('users').doc(user.uid).collection('routes').add({
        'path': serializedRoute,
        "distance": '${(_calculateDistance(_recordedPath)/1000).toStringAsFixed(3)}km',
        "duration": "$dhours s, $dminutes dk",
        'ts': DateFormat('HH:mm').format(_start!),
        'te': DateFormat('HH:mm').format(_end),
        'day': days[_start!.weekday % 7],
        'date': DateFormat('dd/MM/yyyy').format(_start!),
      });
    } else {
      print("Kayıtlı kullanıcı yok.");
    }
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