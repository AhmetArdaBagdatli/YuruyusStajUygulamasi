import '../widgets/recorditem.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RecordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top blue section with logo
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 53, 114, 225), Color.fromARGB(255, 35, 94, 203)],
              ),
            ),
            height: 100,
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2, style: BorderStyle.solid),
                ),
                child: Center(child: Text('Logo', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 41, 58),
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  RecordItem(
                    date: '05.07.2024',
                    day: 'Cum',
                    ts: '12:00',
                    te: '15:12',
                    duration: '3s 12dk',
                    distance: '11.2km',
                    path: [
                        LatLng(40.7829, -73.9654), // Central Park South
                        LatLng(40.7892, -73.9673), // Central Park West
                        LatLng(40.7929, -73.9588), // Central Park North
                        LatLng(40.7736, -73.9655), // 5th Avenue
                        LatLng(40.7829, -73.9654), // Back to start
                      ],
                  ),
                  RecordItem(
                    date: '04.07.2024',
                    day: 'Prs',
                    ts: '11:11',
                    te: '11:53',
                    duration: '42dk',
                    distance: '2.5km',
                    path: [
                        LatLng(37.7749, -122.4194), // San Francisco City Hall
                        LatLng(37.7785, -122.4156), // Union Square
                        LatLng(37.7952, -122.4028), // Fisherman's Wharf
                        LatLng(37.8083, -122.4156), // Fort Mason
                        LatLng(37.8024, -122.4058), // Lombard Street
                        LatLng(37.7749, -122.4194), // Back to City Hall
                      ],
                  ),
                  // Add more RecordItems here as needed
                ],
              ),
            ),
          ),
          // Bottom blue section with "Ana Sayfa" button
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 53, 114, 225), Color.fromARGB(255, 35, 94, 203)],
              ),
            ),
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Ana Sayfa'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                  foregroundColor: Color.fromARGB(255, 231, 244, 255),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/mainmenu');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}