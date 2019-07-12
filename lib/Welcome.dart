import 'package:flutter/material.dart';
import 'Login.dart';
import 'ReusableComponents/ReusableComponents.dart';
import 'Register.dart';
import 'package:free_chat/ReusableComponents/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('R.C.O.E CONFESSION',
              style: kAppBarTextStyle,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image(image: AssetImage('assets/Images/welcome.png')),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BasicTextButton(
                      text: 'LOG IN',
                      onpressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  BasicTextButton(
                      text: 'SIGN UP',
                      onpressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
