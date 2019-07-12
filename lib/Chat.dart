import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_chat/ReusableComponents/constants.dart';
import 'package:free_chat/ReusableComponents/ReusableComponents.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String msg;
  FirebaseUser loggedInUser;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      } else {
        print('no user found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(' 💖 CONFESSIONS 💀', style: kAppBarTextStyle,),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(backgroundColor: kLightPrimaryColor,),
                  );
                }
                final messages = snapshot.data.documents.reversed;
                List<RMessageUI> messageWidgets = [];
                for(var msg in messages){
                  final messageText = msg.data['text'];
                  final messageSender = msg.data['sender'];
                  final currentUser = loggedInUser.email;
                  final messageWidget = RMessageUI(text: messageText,sender: messageSender,isMe: currentUser == messageSender);
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView(
                    children: messageWidgets,
                    reverse: true,
                  ),
                );
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      msg = value;
                    },
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': msg,
                        'sender': loggedInUser.email
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: kAccentColor,

                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




// testing Streams using function ie without StreamBuilder
//  void getStreamSnapshots() async{
//    await for(var firebase_snapshot in _firestore.collection('messages').snapshots()){
//      for (var message in firebase_snapshot.documents){
//        print(message.data);
//    }
//   }
//  }
