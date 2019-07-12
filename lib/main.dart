import 'package:flutter/material.dart';
import 'package:free_chat/Login.dart';
import 'package:free_chat/Welcome.dart';
import 'package:free_chat/Register.dart';
import 'package:free_chat/Chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
