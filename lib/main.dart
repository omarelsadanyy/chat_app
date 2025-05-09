import 'package:chat_app/BLoc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/regitser_screen.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer=SimpleBlocObserver();
  runApp(const ChatApp());
}

 class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        routes: { 
          LoginScreen.id :(context) => LoginScreen(),
          RegitserScreen.id :(context) => RegitserScreen(),
          ChatScreen.id :(context) => ChatScreen(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'LoginScreen',
      ),
    );
  }
}
