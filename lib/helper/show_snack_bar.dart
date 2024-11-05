import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(massage),
      backgroundColor: kPrimaryAppBarColor,
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
