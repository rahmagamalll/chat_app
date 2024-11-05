import 'package:chat_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_fild.dart';
import 'package:chat_app/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignUpForm extends StatelessWidget {
  String? passwordData;
  String? emailData;
  static String id = 'SignUpPage';
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          isLoading = false;
          ShowSnackBar(context, 'success.');
          Navigator.pushNamed(context, LoginForm.id);
        } else if (state is SignupFailure) {
          isLoading = false;
          ShowSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          // pakage
          blur: 0,
          progressIndicator: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryAppBarColor),
          ),
          inAsyncCall: isLoading,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Image.asset(
                  'assets/logo.jpeg',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormFild(
                  hintText: 'Email',
                  onChanged: (data) {
                    emailData = data;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormFild(
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (data) {
                    passwordData = data;
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  buttonName: 'Sign Up',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<SignupCubit>(context).SignUpUser(
                          emailData: emailData!, passwordData: passwordData!);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account,",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        " Log In",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      " Now",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }

}



