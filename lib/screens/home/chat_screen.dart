import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/screens/home/profile_screen.dart';
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
                  onTap: () =>
                      Navigator.of(context).pushNamed(ProfileScreen.routeName),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/dp0.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theresa Web',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
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
                    ? const EdgeInsets.only(left: 0.3, bottom: 15)
                    : const EdgeInsets.only(right: 0.3, bottom: 15),
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
          const SendMessage(),
        ],
      ),
    );
  }
}