import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordDetailMap extends StatefulWidget {
  final List<LatLng> displayedPath;

  const RecordDetailMap({
    Key? key,
    required this.displayedPath,
  }) : super(key: key);

  @override
  State<RecordDetailMap> createState() => _RecordDetailMapState();
}

class _RecordDetailMapState extends State<RecordDetailMap> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  Map<PolylineId, Polyline> _polylines = {};
  LatLng? _initialPosition;

  @override
  void initState() {
    super.initState();
    _updatePolyline();
    if (widget.displayedPath.isNotEmpty) {
      _initialPosition = widget.displayedPath.first;
    }
  }

  void _updatePolyline() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: widget.displayedPath,
      width: 5,
    );
    setState(() {
      _polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: CameraPosition(target: _initialPosition!, zoom: 16),
            polylines: Set<Polyline>.of(_polylines.values),
          );
  }
}