import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_1/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient box at the top (unchanged)
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
          // Rest of the content
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 17, 41, 58),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 25),
                      Text('Yeni Hesap', textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 24)),
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
                        child: _isLoading 
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Yeni Hesap Oluştur'),
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        child: Text('Girişe Geri Dön', style: TextStyle(color: Colors.blue)),
                        onPressed: () {
                          Navigator.pop(context); 
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signupEmailPass(email, password);

    if (user != null){
      print('User created: ${user.uid}');
      Navigator.pushNamed(context, "/mainmenu");
    }
    else{
      print('User creation failed');
    }

  }
}