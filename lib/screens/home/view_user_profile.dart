import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/account_info.dart';
import 'package:messaging_app/widgets/setting_item.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class ViewUserProfileScreen extends StatefulWidget {
  static const String routeName = 'view-user-profile-screen';
  const ViewUserProfileScreen({super.key});

  @override
  State<ViewUserProfileScreen> createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  final ImagePicker picker = ImagePicker();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    CustomUser user = ModalRoute.of(context)!.settings.arguments as CustomUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Builder(
          builder: (_) {
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
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: user.imageUrl.isNotEmpty
                                ? BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(user.imageUrl),
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
                            user.name,
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
                        info: '@${user.userId}',
                        detail: 'Username',
                      ),
                      AccountInfo(
                        info: user.bio,
                        detail: 'Bio',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
