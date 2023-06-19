import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/helpers/shared_preferences.dart';
import 'package:messaging_app/screens/home/add_contact_screen.dart';
import 'package:messaging_app/screens/home/chat_screen.dart';
import 'package:messaging_app/screens/home/friends_list.dart';
import 'package:messaging_app/screens/home/home_screen.dart';
import 'package:messaging_app/screens/home/profile_screen.dart';
import 'package:messaging_app/screens/home/view_user_profile.dart';
import 'package:messaging_app/screens/welcome/welcome.dart';
import 'package:messaging_app/screens/welcome/log_in.dart';
import 'package:messaging_app/screens/welcome/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  logger.i('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {}
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MessagingApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i("Handling a background message: ${message.messageId}");
}

class MessagingApp extends StatelessWidget {
  MessagingApp({super.key});

  final SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prefs.appState(),
      builder: (_, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Gilroy'),
            initialRoute:
                snapShot.data! ? HomeScreen.routeName : Welcome.routeName,
            routes: {
              ViewUserProfileScreen.routeName: (_) =>
                  const ViewUserProfileScreen(),
              FriendsList.routeName: (_) => const FriendsList(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
              AddContactScreen.routeName: (_) => const AddContactScreen(),
              ChatScreen.routeName: (_) => const ChatScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              Welcome.routeName: (_) => const Welcome(),
              SignUp.routeName: (_) => const SignUp(),
              LogIn.routeName: (_) => const LogIn(),
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
