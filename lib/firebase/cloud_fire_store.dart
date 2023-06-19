import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/message.dart';
import 'package:messaging_app/models/user.dart';

class CloudFireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: true);
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
            imageUrl: '',
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String id) async {
    try {
      return firestore.collection('users').doc(id).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getlastMessage(
      String id) async {
    try {
      return firestore
          .collection('chats')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('message-sent')
          .doc(id)
          .get();
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

  Future<QuerySnapshot<Map<String, dynamic>>> getFriends() async {
    try {
      QuerySnapshot<Map<String, dynamic>> collections =
          await firestore.collection('users').get();
      QueryDocumentSnapshot<Map<String, dynamic>> result = collections.docs
          .firstWhere((element) =>
              CustomUser.fromJson(element.data()).userId ==
              firebaseAuth.currentUser!.uid);
      List friendsList = result.data()['friends'];

      return firestore
          .collection('users')
          .where('email', whereIn: [...friendsList]).get();
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

  Future<void> sendMessage(String message, String recipentId) async {
    try {
      await firestore
          .collection('chats')
          .doc(recipentId)
          .collection('message-sent')
          .doc(firebaseAuth.currentUser!.uid)
          .set({
        'timeOfLastMessage': Timestamp.now(),
        'message': message,
      });

      await firestore
          .collection('chats')
          .doc(recipentId)
          .collection('message-sent')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('messages')
          .add(Message(
            message: message,
            isSender: firebaseAuth.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toJson());
      await firestore
          .collection('chats')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('message-sent')
          .doc(recipentId)
          .set({
        'timeOfLastMessage': Timestamp.now(),
        'message': message,
      });

      await firestore
          .collection('chats')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('message-sent')
          .doc(recipentId)
          .collection('messages')
          .add(Message(
            message: message,
            isSender: firebaseAuth.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toJson());
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
