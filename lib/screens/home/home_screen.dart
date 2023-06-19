import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/screens/home/add_contact_screen.dart';
import 'package:messaging_app/screens/home/friends_list.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/app_drawer.dart';
import 'package:messaging_app/widgets/top_bar.dart';
import 'package:messaging_app/widgets/user_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Column(
        children: [
          TopBar(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const FaIcon(
                          FontAwesomeIcons.bars,
                          color: AppColor.mainColor,
                        ),
                      );
                    }),
                    const Text(
                      'Message Me',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AddContactScreen.routeName),
                      icon: const FaIcon(
                        FontAwesomeIcons.plus,
                        color: AppColor.mainColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: List<Widget>.generate(
                //     tabList.length,
                //     (index) => TabListItem(
                //       text: tabList[index],
                //       isSelected: counter == index,
                //       onTap: () => setState(() {
                //         counter = index;
                //       }),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firebaseFirestore
                  .collection('chats')
                  .doc(firebaseAuth.currentUser!.uid)
                  .collection('message-sent')
                  .snapshots(),
              builder: (context, snapshot) {
                try {
                  List<String> messageIds = [];
                  for (var element in snapshot.data!.docs) {
                    messageIds.add(element.id);
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }
                  if (snapshot.data == null) {
                    return const Center(child: Text('No messages yet'));
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => UserItem(
                        id: messageIds[index],
                      ),
                      itemCount: messageIds.length,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                } catch (e) {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(FriendsList.routeName),
        backgroundColor: AppColor.mainColor,
        child: const FaIcon(
          FontAwesomeIcons.pen,
          color: Colors.white,
        ),
      ),
    );
  }
}
