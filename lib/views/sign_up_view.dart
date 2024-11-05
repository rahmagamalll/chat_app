import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  static String id = 'signupPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SignUpForm(),
      ),
    );
  }
}
