import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';

class CloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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

  Future<QuerySnapshot<Map<String, dynamic>>> readUsersData() async {
    try {
      Iterable<Object?>? items;
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((docs) {
        items = docs.data()!['friends'];
      });
      logger.i(items);
      return firestore
          .collection('users')
          .where('friends', arrayContainsAny: items)
          .get();
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
