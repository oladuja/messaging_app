import 'package:flutter/material.dart';
import 'package:messaging_app/static/colors.dart';


class AccountInfo extends StatelessWidget {
  final String info;
  final String detail;

  const AccountInfo({
    super.key,
    required this.info,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          info,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColor.darkGreyColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            color: AppColor.darkGreyColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
