import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';

class ContactWidget extends StatefulWidget {
  final CustomUser user;

  const ContactWidget({
    super.key,
    required this.user,
  });

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  bool onClicked = false;

  @override
  Widget build(BuildContext context) {
    if (widget.user.email != FirebaseAuth.instance.currentUser?.email) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: widget.user.imageUrl.isNotEmpty
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.user.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/unknown.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          title: Text(
            widget.user.email,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            widget.user.bio,
            style: const TextStyle(
              fontSize: 12,
              color: AppColor.mainColor,
            ),
          ),
          trailing: onClicked
              ? const Text('Added')
              : TextButton(
                  onPressed: () async {
                    await CloudFireStore().addUserToFriendList({
                      'friends': FieldValue.arrayUnion([widget.user.email]),
                    });
                    setState(() {
                      onClicked = true;
                    });
                  },
                  child: const Text('Add'),
                ),
        ),
      );
    }
    return Container();
  }
}
