import 'package:flash_chat/components/rounded.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {

  static const String id ='login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  {

  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                 email = value;
                },
                decoration:kTextFileDecor.copyWith(hintText: "Enter email"),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 password = value;
                },
                decoration: kTextFileDecor.copyWith(hintText: "Enter Password"),
              ),

              Paddin(text: "Login", color: Colors.lightBlueAccent, navi: () async {
                setState(() {
                  showSpinner = true;
                });

                try {
                  final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch(e) {
                  print(e);
                }

              }, )

            ],
          ),
        ),
      ),
    );
  }
}

