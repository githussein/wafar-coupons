import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // get a collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future updateUserData(
    String name,
    String email,
    String gender,
    String phone,
    String country,
    String age,
  ) async {
    // create a FireStore document for this user using uid
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'gender': gender,
      'phone': phone,
      'country': country,
      'age': age,
    });
  }
}
