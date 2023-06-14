import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';

class CloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void addUserToDatabase(
      UserCredential userCredential, String bio, String name) async {
    try {
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(CustomUser(
            bio: bio,
            email: userCredential.user!.email!,
            name: name,
            userId: userCredential.user!.uid,
            friends: [],
          ).toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readUsersData() async {
    try {
      Iterable<Object?>? items = [];
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((docs) {
        items = docs.data()!['friends'].toList();
      });
      logger.i(items);
      if (items!.isNotEmpty) {
        return firestore
            .collection('users')
            .where('email', whereNotIn: [...items!]).get();
      }
      return firestore.collection('users').get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> loadUsersData() {
    try {
      return firestore
          .collection('users')
          .where('userId', whereIn: [firebaseAuth.currentUser!.uid]).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFriends() {
    try {
      return firestore.collection('users').get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUserToFriendList(Map<Object, Object> data) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .update(data);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
