import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const SettingItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
        color: Colors.black,
        size: 18,
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
      ),
    );
  }
}
