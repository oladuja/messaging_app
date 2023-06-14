import 'package:firebase_auth/firebase_auth.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/helpers/shared_preferences.dart';

class Auth {
  static Future<void> createAccount(
      String emailAddress, String password, String bio, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      CloudFireStore().addUserToDatabase(credential, bio, name);
      var sp = SharedPrefs();
      sp.loggedIn();
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      rethrow;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<void> logIn(String emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      var sp = SharedPrefs();
      sp.loggedIn();
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      rethrow;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      var sp = SharedPrefs();
      sp.logOut();
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      rethrow;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
