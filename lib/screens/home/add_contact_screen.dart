import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/contact_widget.dart';
import 'package:messaging_app/widgets/top_bar.dart';

class AddContactScreen extends StatefulWidget {
  static const String routeName = 'add-contact-screen';
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
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
                  'Add User',
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
              future: CloudFireStore().readUsersData(),
              builder: (context, snapshot) {
                try {
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data =
                      snapshot.data?.docs;
                  if (snapshot.connectionState == ConnectionState.done) {
                    // logger.i(data);
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      itemBuilder: (context, index) {
                        final CustomUser user =
                            CustomUser.fromJson(data[index].data());
                        return ContactWidget(user: user);
                      },
                      itemCount: data!.length,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                } catch (e) {
                  // logger.e(e);
                  return const Center(child: Text('Search to add user'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
