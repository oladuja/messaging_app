import 'package:flutter/material.dart';

class TextTextField extends StatelessWidget {
  final TextEditingController controller;

  const TextTextField({
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
          keyboardType: TextInputType.text,
          enabled: true,
          decoration: const InputDecoration(
            isDense: true,
            hintText: 'type..',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
