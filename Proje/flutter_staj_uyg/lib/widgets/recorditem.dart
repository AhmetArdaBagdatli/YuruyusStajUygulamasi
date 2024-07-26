
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../pages/recorddetailspage.dart';

class RecordItem extends StatelessWidget {
  final String date;
  final String day;
  final String duration;
  final String distance;
  final List<LatLng> path;

  const RecordItem({
    Key? key,
    required this.date,
    required this.day,
    required this.duration,
    required this.distance,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecordDetailPage(
              date: date,
              timeRange: '00:00 - 23:59', // You might want to add this as a parameter
              distance: distance,
              duration: duration,
              path: path,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Color.fromRGBO(8, 31, 47, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Süre: $duration',
                  style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 14),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  day,
                  style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  distance,
                  style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}