import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/screens/home/add_contact_screen.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/static/tab.dart';
import 'package:messaging_app/widgets/app_drawer.dart';
import 'package:messaging_app/widgets/tab_list_item.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(
                    tabList.length,
                    (index) => TabListItem(
                      text: tabList[index],
                      isSelected: counter == index,
                      onTap: () => setState(() {
                        counter = index;
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: CloudFireStore().getFriends(),
              builder: (context, snapshot) {
                QueryDocumentSnapshot<Map<String, dynamic>> friendsList =
                    snapshot.data!.docs.firstWhere((element) =>
                        CustomUser.fromJson(element.data()).userId ==
                        firebaseAuth.currentUser!.uid);
                logger.i(friendsList.data()['friends']);
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  itemBuilder: (context, index) => const UserItem(),
                  itemCount: 15,
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.mainColor,
        child: const FaIcon(
          FontAwesomeIcons.pen,
          color: Colors.white,
        ),
      ),
    );
  }
}
