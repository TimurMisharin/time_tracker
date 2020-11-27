import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final User user =
              snapshot.data; //data is user because streamBuilder<User>;
          if (user != null && user.uid.isNotEmpty) {
            return HomePage(
              auth: auth,
            );
          } else {
            return SignInPage(
              auth: auth,
            );
          }
        }
      },
    );
  }
}
