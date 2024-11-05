import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomTextFormFild extends StatelessWidget {
  Function(String)? onChanged;
  String? hintText;
  bool? obscureText;

  CustomTextFormFild(
      {super.key, this.hintText, this.onChanged, this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is required.';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
        errorStyle: const TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 237, 235, 235), width: 55),
        ),
      ),
    );
  }
}
