import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:messaging_app/static/colors.dart';


class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            onSubmitted: (value) {
              controller.clear();
            },
            keyboardType: TextInputType.text,
            enabled: true,
            decoration: const InputDecoration(
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
        ),
      ),
    );
  }
}
