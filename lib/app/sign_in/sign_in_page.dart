import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/auth.dart';

//sign in page widget
class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.auth, @required this.onSignIn})
      : super(key: key);

  //pass user object when we call it
  final void Function(User) onSignIn;

  final AuthBase auth;

  Future<void> _singInAnonymously() async {
    try {
      final user = await auth.signInAnonymously();
      onSignIn(user);
    } catch (e) {
      print('_singInAnonymously exception: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    //app layout
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        //shadow of appBar
        elevation: 2.0,
      ),
      //body of widget
      body: _buildContent(),
      backgroundColor: Colors.blueGrey[100],
    );
  }

  //private method is with _
  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      //container child can be any widget in flutter
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //sing in text
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            //style text
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
          ),
          // to add space between containers
          SizedBox(
            height: 48.0,
          ),
          //material button
          SocialSignInButton(
            text: 'Google',
            assertName: 'images/google-logo.png',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: 'Facebook',
            assertName: 'images/facebook-logo.png',
            textColor: Colors.white,
            color: Color(0XFF334D92),
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: 'email',
            assertName: 'images/mail-logo.png',
            textColor: Colors.black87,
            color: Colors.white70,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'OR',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black87,
            color: Colors.blueAccent,
            onPressed: _singInAnonymously,
          ),
        ],
      ),
    );
  }
}
