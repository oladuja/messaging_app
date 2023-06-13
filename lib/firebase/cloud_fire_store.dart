import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/models/user.dart';

class CloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);

  void addUserToDatabase(UserCredential userCredential) async {
    try {
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(CustomUser(
            bio: '',
            email: userCredential.user!.email!,
            name: '',
            phoneNumber: '',
            username: '',
            friends: [],
          ).toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readUsersData() {
    try {
      return firestore.collection('users').get();
    } catch (e) {
      rethrow;
    }
  }
}
