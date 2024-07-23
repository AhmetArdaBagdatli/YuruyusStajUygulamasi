import 'package:flutter/material.dart';
import '../widgets/recorditem.dart';

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
                    duration: '3s 12dk',
                    distance: '11.2km',
                    isLatest: true,
                  ),
                  RecordItem(
                    date: '04.07.2024',
                    day: 'Prs',
                    duration: '42dk',
                    distance: '2.5km',
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