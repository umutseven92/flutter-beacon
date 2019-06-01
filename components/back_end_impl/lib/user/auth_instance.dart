import 'package:firebase_auth/firebase_auth.dart';

class AuthInstance {
  
  final FirebaseAuth auth;

  const AuthInstance({
    this.auth
  });

  Future<FirebaseUser> signIn(){
    return auth.signInAnonymously();
  }

}