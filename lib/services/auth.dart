import 'package:firebase_auth/firebase_auth.dart';
import './database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //sign in with email and password
  Future login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //register with email and password
  Future signup(Map<String, String> _authData) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _authData['email'],
        password: _authData['password'],
      );

      //create a new FireStore document for the user using uid
      final currentUser = FirebaseAuth.instance.currentUser;
      print('>>>> uid: ${currentUser.uid}');
      await DatabaseService(uid: currentUser.uid).updateUserData(
        _authData['name'],
        _authData['email'],
        _authData['gender'],
        _authData['phone'],
        _authData['country'],
        _authData['age'],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "signed out";
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
  }
}
