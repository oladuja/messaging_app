import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Text(
              'Message Me',
              style: TextStyle(
                color: AppColor.mainColor,
                fontSize: 30.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SignUp.routeName),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
                SizedBox(width: 25.w),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LogIn.routeName),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14.sp,
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
