import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            offset: const Offset(0, 15),
            blurRadius: 18,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          onSubmitted: (value) {},
          keyboardType: TextInputType.emailAddress,
          enabled: true,
          decoration: const InputDecoration(
            isDense: true,
            hintText: 'example@email.com',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: FaIcon(
                FontAwesomeIcons.envelope,
                size: 18,
                color: Colors.grey,
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
