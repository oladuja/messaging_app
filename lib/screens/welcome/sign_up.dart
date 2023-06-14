import 'package:flutter/material.dart';
import 'package:messaging_app/helpers/email_validator.dart';
import 'package:messaging_app/firebase/auth.dart';
import 'package:messaging_app/screens/home/home_screen.dart';
import 'package:messaging_app/screens/welcome/log_in.dart';
import 'package:messaging_app/static/colors.dart';
import 'package:messaging_app/widgets/email_textfield.dart';
import 'package:messaging_app/widgets/password_textfield.dart';
import 'package:messaging_app/widgets/text_textfield.dart';

class SignUp extends StatefulWidget {
  static const String routeName = 'sign-up';

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isClicked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

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
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.mainColor,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Email Address',
                style: TextStyle(fontSize: 14),
              ),
              EmailTextField(controller: emailController),
              const SizedBox(height: 25),
              const Text(
                'Bio',
                style: TextStyle(fontSize: 14),
              ),
              TextTextField(controller: bioController),
              const SizedBox(height: 25),
              const Text(
                'Name',
                style: TextStyle(fontSize: 14),
              ),
              TextTextField(controller: nameController),
              const SizedBox(height: 25),
              const Text(
                'Password',
                style: TextStyle(fontSize: 14),
              ),
              PasswordTextfield(controller: passwordController),
              const SizedBox(height: 25),
              const Text(
                'Confirm Password',
                style: TextStyle(fontSize: 14),
              ),
              PasswordTextfield(controller: confirmPasswordController),
              const SizedBox(height: 25),
              Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).popAndPushNamed(LogIn.routeName),
                    child: const Text('Already have an account?'),
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

                        if (!(passwordController.text ==
                            confirmPasswordController.text)) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password not the same'),
                            ),
                          );
                          setState(() {
                            isClicked = false;
                          });
                          return;
                        }

                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Name can\'t be empty'),
                            ),
                          );
                          setState(() {
                            isClicked = false;
                          });
                          return;
                        }

                        if (bioController.text.isEmpty) {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bio can\'t be empty'),
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
                              content: Text('Passwords must be greater than 6'),
                            ),
                          );
                          setState(() {
                            isClicked = false;
                          });
                          return;
                        }
                        if (emailValidator(emailController.text) &&
                            (passwordController.text ==
                                confirmPasswordController.text) &&
                            (passwordController.text.length > 6) &&
                            bioController.text.isNotEmpty &&
                            nameController.text.isNotEmpty) {
                          try {
                            await Auth.createAccount(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              bioController.text.trim(),
                              nameController.text.trim(),
                            );
                            setState(() {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName, (route) => false);
                              isClicked = false;
                              // showDialogAndClose(context);
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
                      child: const Text('Sign Up'),
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
