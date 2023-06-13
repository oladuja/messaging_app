import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';

class ContactWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const ContactWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final CustomUser user = CustomUser.fromJson(data);
    if (user.email != FirebaseAuth.instance.currentUser?.email) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
          title: Text(
            user.email,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            user.bio,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.mainColor,
            ),
          ),
          trailing: TextButton(
            onPressed: () {},
            child: const Text('Add'),
          ),
        ),
      );
    }
    return Container();
  }
}
