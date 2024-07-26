import '../widgets/recorddetailmap.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordDetailPage extends StatelessWidget {
  final String date;
  final String timeStart;
    final String timeEnd;
  final String distance;
  final String duration;
  final List<LatLng> path;

  const RecordDetailPage({
    Key? key,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.distance,
    required this.duration,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Color.fromARGB(255, 17, 41, 58),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeStart + " - " + timeEnd,
                        style: const TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18),
                      ),
                      Text(
                        date,
                        style: const TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        duration,
                        style: const TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18),
                      ),
                      Text(
                        distance,
                        style: const TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RecordDetailMap(displayedPath: path),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF1E1E1E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Geri'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 17, 41, 58),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement delete functionality
                    },
                    child: const Text('Sil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 17, 41, 58),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}