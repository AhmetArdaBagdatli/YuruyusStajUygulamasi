import 'package:flutter/material.dart';
import './weatherboard.dart';

class MainMenuPage extends StatelessWidget {
  final String apiKey = 'e6b443ec7352d6f2294012d586e0285f'; // Replace with your OpenWeatherMap API key
  final String city = 'Istanbul'; // Replace with the desired city

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Weather board
                  SizedBox(height: 50),
                  WeatherBoard(apiKey: apiKey, city: city),
                  SizedBox(height: 50),
                  // New Entry button
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Yeni Kayıt'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(height: 50),
                  // Records button
                  ElevatedButton.icon(
                    icon: Icon(Icons.bookmark),
                    label: Text('Kayıtlar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/recordspage');
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom blue section
          Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 53, 114, 225), Color.fromARGB(255, 35, 94, 203)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}