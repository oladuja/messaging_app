import 'package:flutter/material.dart';
import 'package:messaging_app/screens/welcome/log_in.dart';
import 'package:messaging_app/screens/welcome/sign_up.dart';
import 'package:messaging_app/static/colors.dart';

class Welcome extends StatelessWidget {
  static const String routeName = 'Welcome-screen';

  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Message Me',
              style: TextStyle(
                color: AppColor.mainColor,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SignUp.routeName),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LogIn.routeName),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
