import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/screens/home/chat_screen.dart';
import 'package:messaging_app/static/colors.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.email,
  });
  final QueryDocumentSnapshot<Map<String, dynamic>> email;

  @override
  Widget build(BuildContext context) {
    logger.i(email);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(ChatScreen.routeName),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/dp0.png'),
            ),
          ),
        ),
        title: const Text(
          'Theresa Webb',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'How are you doing?',
          style: TextStyle(
            fontSize: 12,
            color: AppColor.mainColor,
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  '15:20',
                  style: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.all(6.0),
                  child: const Text(
                    '12',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
