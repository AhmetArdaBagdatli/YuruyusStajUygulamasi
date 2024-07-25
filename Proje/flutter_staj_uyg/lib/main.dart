import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/loginpage.dart';
import 'pages/signuppage.dart';
import 'pages/mainmenu.dart';
import 'pages/recordspage.dart';
import 'pages/recordingpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('tr_TR', null).then((_) => runApp(MyApp2()));
}


class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecordingPage(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/mainmenu': (context) => MainMenuPage(),
        '/recordspage': (context) => RecordsPage(),
      },
    );
  }
}
