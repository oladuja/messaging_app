import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/friend_item.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class FriendsList extends StatelessWidget {
  static const String routeName = 'friends-list';
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBar(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const FaIcon(
                    FontAwesomeIcons.angleLeft,
                    color: AppColor.mainColor,
                  ),
                ),
                const Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColor.mainColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: CloudFireStore().getFriends(),
              builder: (context, snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      itemBuilder: (context, index) => FriendItem(
                          user: CustomUser.fromJson(docs[index].data())),
                      itemCount: docs.length,
                    );
                  }
                  logger.i(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container();
                } catch (e) {
                  return const Center(child: Text('No Friends'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
