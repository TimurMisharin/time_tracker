import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/auth.dart';

//sign in page widget
class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _singInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print('_singInAnonymously exception: ${e.toString()}');
    }
  }

  Future<void> _singInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print('_singInWithGoogle exception: ${e.toString()}');
    }
  }

  Future<void> _singInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print('_singInWithFacebook exception: ${e.toString()}');
    }
  }

  void _signInWithEmail(BuildContext context) {
    //show email sign in page
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true, // page come from bottom
        builder: (context) => EmailSignInPage(
          auth: auth,
        ),
      ),
    );
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
      body: _buildContent(context),
      backgroundColor: Colors.blueGrey[100],
    );
  }

  //private method is with _
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      //container child can be any widget in flutter
      child: SingleChildScrollView(
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
              onPressed: _singInWithGoogle,
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: 'Facebook',
              assertName: 'images/facebook-logo.png',
              textColor: Colors.white,
              color: Color(0XFF334D92),
              onPressed: _singInWithFacebook,
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: 'email',
              assertName: 'images/mail-logo.png',
              textColor: Colors.black87,
              color: Colors.white70,
              onPressed: () => _signInWithEmail(context),
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
      ),
    );
  }
}
