import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/Login_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:chat_app/widgets/login_form.dart';
import 'package:chat_app/widgets/sign_up_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // configration mn el terminal w bna5tar el database el ban3arafha
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}
// chat-app-bd7fa0

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          SignUpView.id: (context) => SignUpView(),
          ChatPage.id: (context) => ChatPage(),
          SignUpForm.id: (context) => SignUpForm(),
          LoginForm.id: (context) => LoginForm(),
          LoginView.id: (context) => const LoginView(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginView.id,
      ),
    );
  }
}
