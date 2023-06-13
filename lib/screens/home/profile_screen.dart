import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/account_info.dart';
import 'package:messaging_app/widgets/setting_item.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'profile-screen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  const Text(
                    '@theresa',
                    style: TextStyle(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/dp0.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theresa Webb',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '+375(29)9638433',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColor.darkGreyColor,
                            ),
                          ),
                        ],
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
                  const AccountInfo(
                    info: '+375(29)9638433',
                    detail: 'Tap to change phone number',
                  ),
                  const AccountInfo(
                    info: '@theresa',
                    detail: 'Username',
                  ),
                  const AccountInfo(
                    info:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac est pulvinar metus fermentum vehicula vitae porta lectus. Pellentesque libero nisi',
                    detail: 'Bio',
                  ),
                  const Text(
                    'Settings',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SettingItem(
                    text: 'Notification and Sounds',
                    icon: FontAwesomeIcons.bell,
                  ),
                  const SettingItem(
                    text: 'Privacy and Security',
                    icon: FontAwesomeIcons.lock,
                  ),
                  const SettingItem(
                    text: 'Data and Storage',
                    icon: FontAwesomeIcons.database,
                  ),
                  const SettingItem(
                    text: 'Chat settings',
                    icon: FontAwesomeIcons.message,
                  ),
                  const SettingItem(
                    text: 'Devices',
                    icon: FontAwesomeIcons.laptop,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
