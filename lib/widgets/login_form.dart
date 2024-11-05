import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_fild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String? passwordData;
  String? emailData;
  bool isLoading = false;
  static String id = 'LogInPage';

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginLoding) {
        isLoading = true;
      } else if (state is LoginSuccess) {
        isLoading = false;
        ShowSnackBar(context, 'success.');

        BlocProvider.of<ChatCubit>(context).getMessages(); 

        Navigator.pushNamed(context, ChatPage.id, arguments: emailData);
      } else if (state is LoginFailure) {
        isLoading = false;
        ShowSnackBar(context, state.errMessage);
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        // pakage
        inAsyncCall: isLoading,
        progressIndicator: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryAppBarColor),
        ),
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
                    "Log In",
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).logInUser(
                          emailData: emailData!,
                          passwordData:
                              passwordData!); 
                    }
                  },
                  buttonName: 'Log In'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Dont't have an account,",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpView.id);
                    },
                    child: const Text(
                      " Sign Up",
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
    });
  }

}




