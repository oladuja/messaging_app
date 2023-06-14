import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/image_picker.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/account_info.dart';
import 'package:messaging_app/widgets/setting_item.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'profile-screen';
  ProfileScreen({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: CloudFireStore().loadUsersData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              CustomUser customUser =
                  CustomUser.fromJson(snapshot.data.docs[0].data());
              return Column(
                children: [
                  TopBar(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: AppColor.mainColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          customUser.userId,
                          style: const TextStyle(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => pickImage(),
                              child: Container(
                                width: 45,
                                height: 45,
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
                              customUser.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AccountInfo(
                          info: '@${customUser.userId}',
                          detail: 'Username',
                        ),
                        AccountInfo(
                          info: customUser.bio,
                          detail: 'Bio',
                        ),
                        const Text(
                          'Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SettingItem(
                          text: 'Notification and Sounds',
                          color: Colors.black,
                          icon: FontAwesomeIcons.bell,
                        ),
                        const SettingItem(
                          text: 'Privacy and Security',
                          color: Colors.black,
                          icon: FontAwesomeIcons.lock,
                        ),
                        const SettingItem(
                          text: 'Data and Storage',
                          color: Colors.black,
                          icon: FontAwesomeIcons.database,
                        ),
                        const SettingItem(
                          text: 'Chat settings',
                          color: Colors.black,
                          icon: FontAwesomeIcons.message,
                        ),
                        const SettingItem(
                          text: 'Devices',
                          color: Colors.black,
                          icon: FontAwesomeIcons.laptop,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
