import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_1/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _checkCurrentUser();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200, 
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
                      width: 100,
                      height: 100,
                      child: Image.asset('assets/logo.png', fit: BoxFit.contain),
                    ),
                    SizedBox(width: 10),
                    Text('Go-Route', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                ),
              ),
            ),
          ),
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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                        _signIn();
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
                        _googleSignin();
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

  void _googleSignin() async {
    _auth.signinGoogle();
    User? user = await _auth.signinGoogle();

    if (user != null){
      Navigator.pushNamed(context, "/mainmenu");
    }
  }
  
  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signinEmailPass(email, password);

    if (user != null){
      Navigator.pushNamed(context, "/mainmenu");
    }

  }

  void _checkCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacementNamed('/mainmenu');
    }
  }
}