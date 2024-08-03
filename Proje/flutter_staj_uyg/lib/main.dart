import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/loginpage.dart';
import 'pages/signuppage.dart';
import 'pages/mainmenu.dart';
import 'pages/recordspage.dart';
import 'pages/recordingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('tr_TR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go-Route',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/mainmenu': (context) => MainMenuPage(),
        '/recordspage': (context) => RecordsPage(),
        '/newrecordpage': (context) => RecordingPage(),
      },
    );
  }
}
