import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/auth.dart';
import 'package:messaging_app/screens/home/add_contact_screen.dart';
import 'package:messaging_app/screens/welcome/welcome.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/static/tab.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
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
                    IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              itemBuilder: (context, index) => const UserItem(),
              itemCount: 15,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Auth.logOut();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Welcome.routeName, (route) => false);
      }),
    );
  }
}
