import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/firebase/cloud_fire_store.dart';
import 'package:messaging_app/helpers/logger.dart';
import 'package:messaging_app/static/colors.dart';

class SendMessage extends StatefulWidget {
  final String userId;
  const SendMessage({
    super.key,
    required this.userId,
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
        onSubmitted: (_) {
          setState(() {
            logger.i(controller.text += '\n');
            controller.text += '\n';
          });
        },
        enabled: true,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          enabled: true,
          isDense: true,
          hintText: 'Type your message...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          suffixIcon: GestureDetector(
            onTap: controller.text.trim().isNotEmpty
                ? () {}
                : () async {
                    FocusScope.of(context).unfocus();
                    logger.i(controller.text);
                    try {
                      await CloudFireStore()
                          .sendMessage(controller.text.trim(), widget.userId);
                      controller.clear();
                    } catch (e) {
                      // ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                      logger.i(e);
                    }
                  },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: FaIcon(
                FontAwesomeIcons.solidPaperPlane,
                size: 18,
                color: AppColor.mainColor,
              ),
            ),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
