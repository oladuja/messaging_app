import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/auth.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/screens/home/profile_screen.dart';
import 'package:messaging_app/screens/welcome/welcome.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/setting_item.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    super.key,
  });

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 15,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          children: [
            FutureBuilder(
                future: firebaseFirestore
                    .collection('users')
                    .doc(firebaseAuth.currentUser!.uid)
                    .get(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Container();
                  }
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ProfileScreen.routeName),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/dp0.png'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        snapShot.connectionState == ConnectionState.done
                            ? snapShot.data!.data()!['name']
                            : '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  );
                }),
            const SizedBox(height: 15),
            const SettingItem(
              text: 'Contacts',
              icon: FontAwesomeIcons.user,
              color: AppColor.mainColor,
            ),
            const SettingItem(
              text: 'Calls',
              icon: FontAwesomeIcons.phone,
              color: AppColor.mainColor,
            ),
            const SettingItem(
              text: 'Save Messagges',
              icon: FontAwesomeIcons.bookmark,
              color: AppColor.mainColor,
            ),
            const SettingItem(
              text: 'Invite Friends',
              icon: FontAwesomeIcons.plus,
              color: AppColor.mainColor,
            ),
            const SettingItem(
              text: 'Message Me FAQ',
              icon: FontAwesomeIcons.circleQuestion,
              color: AppColor.mainColor,
            ),
            GestureDetector(
              onTap: () {
                Auth.logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Welcome.routeName, (route) => false);
              },
              child: const SettingItem(
                text: 'Logout',
                icon: FontAwesomeIcons.rightFromBracket,
                color: AppColor.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
