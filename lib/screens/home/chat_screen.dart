import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  onTap: () => Navigator.of(context)
                      .pushNamed(ViewUserProfileScreen.routeName, arguments: user),
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
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: AppColor.mainColor,
                        fontSize: 12,
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              reverse: true,
              itemBuilder: (context, index) => ChatBubble(
                margin: (index % 2 == 1)
                    ? EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3,
                        bottom: 15)
                    : EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.3,
                        bottom: 15),
                padding: const EdgeInsets.all(15.0),
                backGroundColor: (index % 2 == 1)
                    ? AppColor.mainColor
                    : AppColor.lightGreyColor,
                elevation: 0,
                clipper: ChatBubbleClipper5(
                  type: (index % 2 == 1)
                      ? BubbleType.sendBubble
                      : BubbleType.receiverBubble,
                  radius: 35,
                  secondRadius: 10,
                ),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac est pulvinar metus fermentum vehicula vitae porta lectus. Pellentesque libero nisi, finibus sed eleifend in, malesuada nec dolor',
                  style: TextStyle(
                    color: (index % 2 == 1) ? Colors.white : Colors.black,
                  ),
                ),
              ),
              itemCount: 15,
            ),
          ),
           SendMessage(userId: user.userId),
        ],
      ),
    );
  }
}
