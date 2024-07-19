import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import './loginpage.dart';
import './signuppage.dart';
import './mainmenu.dart';
import './recordspage.dart';

void main() {
  initializeDateFormatting('tr_TR', null).then((_) => runApp(MyApp()));
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
