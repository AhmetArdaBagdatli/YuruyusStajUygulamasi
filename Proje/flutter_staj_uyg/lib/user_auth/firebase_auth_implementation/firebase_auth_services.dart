import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?>signupEmailPass(String email, String password) async {

    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      print(e);
    }
    return null;

  }

  void signinGoogle() {
    try {
      GoogleAuthProvider _googleProvider = GoogleAuthProvider();
      _auth.signInWithPopup(_googleProvider);
    } catch(e){
      print(e);
    }
  }

  Future<User?>signinEmailPass(String email, String password) async {

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch(e){
      print(e);
    }
    return null;

  }

}