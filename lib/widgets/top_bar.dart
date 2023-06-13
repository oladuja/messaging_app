import 'package:flutter/material.dart';

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
        top: MediaQuery.of(context).padding.top + 8.0,
        bottom: 8.0,
        right: 15.0,
        left: 15.0,
      ),
      width: double.infinity,
      color: Colors.white,
      child: child,
    );
  }
}
