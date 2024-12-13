import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?>signUpWithEmail(String email, String password, String name) async{
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      return userCredential.user;
  }

  Future<User?>signInWithEmail(String email, String password) async{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
      return userCredential.user;
  }
}