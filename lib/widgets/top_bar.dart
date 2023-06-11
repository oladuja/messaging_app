import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBar extends StatelessWidget {
  final Widget child;
  const TopBar({
    super.key,
    required this.child,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 15.0,
          bottom: 15.0,
          right: 15.0,
          left: 15.0,
        ),
        width: 1.sw,
        color: Colors.white,
        child: child,);
  }
}
