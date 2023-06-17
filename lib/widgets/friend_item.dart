import 'package:flutter/material.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/screens/home/chat_screen.dart';
import 'package:messaging_app/static/colors.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
    required this.user,
  });
  final CustomUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ChatScreen.routeName, arguments: user),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
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
        title: Text(
          user.name,
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
      ),
    );
  }
}
