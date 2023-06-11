import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messaging_app/firebase/auth.dart';
import 'package:messaging_app/helpers/email_validator.dart';
import 'package:messaging_app/screens/home/home_screen.dart';
import 'package:messaging_app/screens/welcome/sign_up.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/email_textfield.dart';
import 'package:messaging_app/widgets/password_textfield.dart';

class LogIn extends StatefulWidget {
  static const String routeName = 'log-in';

  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 75),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mainColor,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Email Address',
                style: TextStyle(fontSize: 14.sp),
              ),
              EmailTextField(controller: emailController),
              SizedBox(height: 25.h),
              Text(
                'Password',
                style: TextStyle(fontSize: 14.sp),
              ),
              PasswordTextfield(controller: passwordController),
              SizedBox(height: 25.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).popAndPushNamed(SignUp.routeName),
                    child: const Text('Create an account?'),
                  ),
                  const Spacer(),
                  if (isClicked) const CircularProgressIndicator(),
                  if (!isClicked)
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColor.mainColor),
                      ),
                      onPressed: () async {
                        setState(() {
                          isClicked = true;
                        });
                        FocusScope.of(context).unfocus();
                        if (!emailValidator(emailController.text)) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email not valid'),
                            ),
                          );
                          setState(() {
                            isClicked = false;
                          });
                          return;
                        }

                        if (!(passwordController.text.length > 6)) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Passwords must be greater than 6 '),
                            ),
                          );
                          setState(() {
                            isClicked = false;
                          });
                          return;
                        }
                        if (emailValidator(emailController.text) &&
                            (passwordController.text.length > 6)) {
                          try {
                            await Auth.logIn(emailController.text.trim(),
                                passwordController.text.trim());
                            setState(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName, (route) => false);
                              isClicked = false;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                            setState(() {
                              isClicked = false;
                            });
                            return;
                          }
                        }
                      },
                      child: const Text('Log In'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
