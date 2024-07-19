
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient box at the top
          Container(
            height: 200, // Adjust this height as needed
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 53, 114, 225), Color.fromARGB(255, 35, 94, 203)],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow, width: 2),
                      ),
                      child: Center(child: Text('Logo', style: TextStyle(color: Colors.white))),
                    ),
                    SizedBox(width: 10),
                    Text('App Name', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
            ),
          ),
          // Rest of the content
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 41, 58),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 25),
                    Text('Giriş',textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 24)),
                    SizedBox(height: 25),
                    TextField(
                      style: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 18, 73, 174)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                      decoration: InputDecoration(
                        hintText: 'Şifre',
                        hintStyle: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color.fromARGB(255, 18, 73, 174)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    ElevatedButton(
                      child: Text('Giriş'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/mainmenu');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      child: Text('Yeni Hesap', style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Google Giriş Butonu'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/mainmenu');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}