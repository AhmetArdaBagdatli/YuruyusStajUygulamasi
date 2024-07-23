import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_1/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RecordDetailsPage extends StatefulWidget {
  const RecordDetailsPage({super.key});

  @override
  State<RecordDetailsPage> createState() => _RecordDetailsPageState();
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  static const LatLng _center = const LatLng(37.4223, -122.0848);
  static const LatLng _center2 = const LatLng(37.3346, -122.0090); 
  LatLng? _currentP = null;

  Location _location = new Location();

  Map<PolylineId, Polyline> _polylines = {};

  List<LatLng> _recordedPath = [];

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    getLocUpdate().then(
      (_) => {
          generatePolylineFromPoints(_recordedPath),
        }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null ? const Center(child: Text("Loading...")) : 
      GoogleMap( 
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      initialCameraPosition: CameraPosition(target: _center, zoom: 13),
      markers: {
        Marker(markerId: MarkerId('_currentlocation'),icon: BitmapDescriptor.defaultMarker , position: _currentP!),
        Marker(markerId: MarkerId('_sourcelocation'),icon: BitmapDescriptor.defaultMarker , position: _center),
        Marker(markerId: MarkerId('_destlocation'),icon: BitmapDescriptor.defaultMarker , position: _center2),
      },
      polylines: Set<Polyline>.of(_polylines.values),
      ),
      );
  }

  Future<void> camToPos(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newPos = CameraPosition(target: pos, zoom: 13);

    await controller.animateCamera(CameraUpdate.newCameraPosition(_newPos));
  }

  Future<void> getLocUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }
    else{
      return;
    }

    _permissionGranted = await _location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await _location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if(currentLocation.latitude != null && currentLocation.longitude != null){
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        camToPos(_currentP!);
        _recordedPath.add(_currentP!);
      }
    });
  }

  void generatePolylineFromPoints(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    _polylines[id] = polyline;
    setState(() {});
  }

  Future<List<LatLng>> getPolLinePoints() async {
    List<LatLng> _plineCoords = [];
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      googleApiKey: GOOGLEMAPS_API_KEY,
      request: PolylineRequest(
        origin: PointLatLng(_center.latitude, _center.longitude),
        destination: PointLatLng(_center.latitude, _center.longitude),
        mode: TravelMode.driving
        ),
    );
    if (result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) {
        _plineCoords.add(LatLng(point.latitude, point.longitude));
        print("We up");
      });
    } else{
      print(result.errorMessage);
    }
    return _plineCoords;
  }
  
}