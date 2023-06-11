import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/user.dart' as user;

class CloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addUserToDatabase(UserCredential userCredential) async {
    try {
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.User(
            bio: '',
            email: userCredential.user!.email!,
            name: '',
            phoneNumber: '',
            username: '',
          ).toJson());
    } catch (e) {
      rethrow;
    }
  }
}
