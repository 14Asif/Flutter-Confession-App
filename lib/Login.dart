import 'package:flutter/material.dart';
import 'package:free_chat/ReusableComponents/constants.dart';
import 'package:free_chat/ReusableComponents/ReusableComponents.dart';
import 'package:free_chat/Chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOG IN',
          style: kAppBarTextStyle,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image(image: AssetImage('assets/Images/login.png')),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    TextFieldForm(text: 'EMAIL',onChanged: (value){
                      email = value;
                    },),
                    TextFieldForm(text: 'PASSWORD',obscureText: true,onChanged: (value){
                      password = value;
                    }),
                    SizedBox(
                      height: 20.0,
                    ),
                    BasicTextButton(
                        text: 'LOG IN',
                        onpressed: () async{
                          setState(() {
                            spinner = true;
                          });
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          try {
                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          }
                          catch(e){print(e);}
                          setState(() {
                            spinner = false;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
