import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/weatherboard.dart';

class MainMenuPage extends StatelessWidget {
  final String apiKey = 'e6b443ec7352d6f2294012d586e0285f';
  final String city = 'Istanbul';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    Text('Ana Sayfa', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 41, 58),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  WeatherBoard(apiKey: apiKey, city: city),
                  SizedBox(height: 10),
                  // New Entry button
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Yeni Kayıt'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/newrecordpage');
                    },
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    label: Text('Hesaptan Ayrıl'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(8, 31, 47, 1),
                      foregroundColor: Color.fromARGB(255, 231, 244, 255),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ),
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