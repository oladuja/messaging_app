import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/screens/home/chat_screen.dart';
import 'package:messaging_app/static/colors.dart';

class UserItem extends StatelessWidget {
  UserItem({
    super.key,
    required this.id,
  });
  final String id;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    logger.i(id);
    return FutureBuilder(
      future: CloudFireStore().getUser(id),
      builder: (context, snapshot) {
        return FutureBuilder(
          future: CloudFireStore().getlastMessage(id),
          builder: (context, msgSnapshot) {
            try {
              CustomUser customUser =
                  CustomUser.fromJson(snapshot.data!.data()!);
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(ChatScreen.routeName, arguments: customUser),
                  child: ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: customUser.imageUrl.isNotEmpty
                          ? BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(customUser.imageUrl),
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
                      customUser.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      msgSnapshot.data!.data()!['message'],
                      style: const TextStyle(
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
                            LastMessageTime(
                                time: msgSnapshot.data!
                                    .data()!['timeOfLastMessage']),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            } catch (e) {
              return Container();
            }
          },
        );
      },
    );
  }
}

class LastMessageTime extends StatefulWidget {
  const LastMessageTime({
    super.key,
    required this.time,
  });

  final Timestamp time;

  @override
  State<LastMessageTime> createState() => _LastMessageTimeState();
}

class _LastMessageTimeState extends State<LastMessageTime> {
  @override
  Widget build(BuildContext context) {
    var time = timeago.format(
      DateTime.fromMicrosecondsSinceEpoch(widget.time.microsecondsSinceEpoch),
      locale: 'en_short',
    );
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    return Text(
      time + ((time == 'now') ? '' : ' ago'),
      style: const TextStyle(
          color: AppColor.darkGreyColor, fontWeight: FontWeight.bold),
    );
  }
}
