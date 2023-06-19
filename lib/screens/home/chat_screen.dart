import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/message.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/screens/home/view_user_profile.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/send_message.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CustomUser user = ModalRoute.of(context)!.settings.arguments as CustomUser;
    return Scaffold(
      body: Column(
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
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                      ViewUserProfileScreen.routeName,
                      arguments: user),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: user.imageUrl.isNotEmpty
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/unknown.png'),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: AppColor.mainColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          StreamBuilder(
            stream: firebaseFirestore
                .collection('chats')
                .doc(firebaseAuth.currentUser!.uid)
                .collection('message-sent')
                .doc(user.userId)
                .collection('messages')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, snapshot) {
              try {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Expanded(child: Text('Loading messages')),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Expanded(
                      child: Text('No message'),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  logger.i(snapshot.data!.docs);

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      // reverse: true,
                      itemBuilder: (context, index) {
                        Message message =
                            Message.fromJson(snapshot.data!.docs[index].data());
                        return BubbleNormal(
                          bubbleRadius: 20,
                          tail: true,
                          isSender: (message.isSender ==
                              firebaseAuth.currentUser!.uid),
                          color: (message.isSender ==
                                  firebaseAuth.currentUser!.uid)
                              ? AppColor.mainColor
                              : AppColor.lightGreyColor,
                          text: message.message,
                          textStyle: TextStyle(
                            color: (message.isSender ==
                                    firebaseAuth.currentUser!.uid)
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  );
                }
                return const CircularProgressIndicator();
              } catch (e) {
                logger.e(e);
                return Container();
              }
            },
          ),
          SendMessage(userId: user.userId),
        ],
      ),
    );
  }
}
