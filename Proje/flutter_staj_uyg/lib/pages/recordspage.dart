import '../widgets/recordslist.dart';

import 'package:flutter/material.dart';


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
            height: 200,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                    ),
                    SizedBox(width: 10),
                    Text('Kayıtlar', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
            ),
          ),
          // Main content area
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 41, 58),
              padding: EdgeInsets.all(16),
              child: RecordList()
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
            child: Row(
              children: [
                Expanded(
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
                SizedBox(width: 16), // Add some spacing between buttons
                Expanded(
                  child: ElevatedButton(
                    child: Text('Yenile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => RecordsPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}