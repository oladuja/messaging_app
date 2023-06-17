import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: CloudFireStore().loadUsersData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            try {
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: customUser.imageUrl.isNotEmpty
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(customUser.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/unknown.png'),
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
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Choose mode',
                                      style:
                                          TextStyle(color: AppColor.mainColor),
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        final id =
                                            firebaseAuth.currentUser!.uid;
                                        try {
                                          XFile? image = await captureImage()
                                              .whenComplete(() =>
                                                  Navigator.of(context).pop());
                                          final ref = firebaseStorage
                                              .ref('images')
                                              .child(id);
                                          await ref.putFile(File(image!.path));
                                          final imageUrl =
                                              await ref.getDownloadURL();
                                          firebaseFirestore
                                              .collection('users')
                                              .doc(id)
                                              .update({
                                            'imageUrl': imageUrl,
                                          });
                                        } catch (e) {
                                          logger.e(e);
                                        }
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.camera,
                                        color: AppColor.mainColor,
                                      ),
                                      label: const Text(
                                        'Take photo',
                                        style: TextStyle(
                                          color: AppColor.mainColor,
                                        ),
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        final id =
                                            firebaseAuth.currentUser!.uid;
                                        try {
                                          XFile? image = await pickImage()
                                              .whenComplete(() =>
                                                  Navigator.of(context).pop());
                                          final ref = firebaseStorage
                                              .ref('images')
                                              .child(id);
                                          await ref.putFile(File(image!.path));
                                          final imageUrl =
                                              await ref.getDownloadURL();
                                          firebaseFirestore
                                              .collection('users')
                                              .doc(id)
                                              .update({
                                            'imageUrl': imageUrl,
                                          });
                                        } catch (e) {
                                          logger.e(e);
                                        }
                                        setState(() {});
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.photoFilm,
                                        color: AppColor.mainColor,
                                      ),
                                      label: const Text(
                                        'Choose from gallery',
                                        style: TextStyle(
                                          color: AppColor.mainColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: const Text(
                              'Change Profile Picture',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkGreyColor,
                              ),
                            ),
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
            } catch (e) {
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
