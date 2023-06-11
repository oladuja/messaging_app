import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextfield({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool obscureText = true;

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
          obscureText: obscureText,
          controller: widget.controller,
          onSubmitted: (value) {
          },
          keyboardType: TextInputType.visiblePassword,
          enabled: true,
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Enter Passsword',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: FaIcon(
                  obscureText
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  size: 18,
                  color: Colors.grey,
                ),
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
