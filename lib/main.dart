import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messaging_app/helpers/shared_preferences.dart';
import 'package:messaging_app/screens/home/add_contact_screen.dart';
import 'package:messaging_app/screens/home/chat_screen.dart';
import 'package:messaging_app/screens/home/home_screen.dart';
import 'package:messaging_app/screens/home/profile_screen.dart';
import 'package:messaging_app/screens/welcome/welcome.dart';
import 'package:messaging_app/screens/welcome/log_in.dart';
import 'package:messaging_app/screens/welcome/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MessagingApp());
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
              ProfileScreen.routeName: (_) => ProfileScreen(),
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
