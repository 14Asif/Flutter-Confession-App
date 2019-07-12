import 'package:flutter/material.dart';
import 'package:free_chat/Chat.dart';
import 'package:free_chat/ReusableComponents/constants.dart';
import 'package:free_chat/ReusableComponents/ReusableComponents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email;
  String password;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGISTER',
          style: kAppBarTextStyle,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                    child: Image(image: AssetImage('assets/Images/register.png')),
                  height: 300.0,
                ),
              ),
              //*************** Should have probably used flexible instead of expanded ...
              //But accidently made a cool animation effect in Login so Whatever ************************
              Flexible(
                child: ListView(
                  children: <Widget>[
                    TextFieldForm(text: 'USERNAME (e.g freaky@comps.com)',onChanged: (value){
                      email = value;
                    },),
                    SizedBox(height: 8.0),
                    TextFieldForm(text: 'PASSWORD',obscureText: true,onChanged: (value){
                      password = value;
                    }),
//                    SizedBox(height: 8.0),
//                    TextFieldForm(text: 'USERNAME',onChanged: (value){
//                      username = value;
//                    },),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BasicTextButton(
                          text: 'SIGN UP',
                          onpressed: () async{
                            setState(() {
                              spinner = true;
                            });
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if(newUser != null){
                                Navigator.pushNamed(context, ChatScreen.id);
                              }
                              setState(() {
                                spinner = false;
                              });
                            }
                            catch(e){
                              print(e);
                            }
                          }),
                    )
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
