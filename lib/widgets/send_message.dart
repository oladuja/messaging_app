import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/static/colors.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({
    super.key,
  });

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {},
        keyboardType: TextInputType.text,
        enabled: true,
        minLines: 1,
        maxLines: 3,
        decoration: const InputDecoration(
          enabled: true,
          isDense: true,
          hintText: 'Type your message...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: FaIcon(
              FontAwesomeIcons.solidPaperPlane,
              size: 18,
              color: AppColor.mainColor,
            ),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
