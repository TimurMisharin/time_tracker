import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

//page to switch between login and context pages
class _LandingPageState extends State<LandingPage> {
  User _user;

  //update user value at application starts
  @override
  void initState() {
    super.initState();
    //widget.auth because auth decelerated at LandingPage
    _updateUser(widget.auth.currentUser);
  }

  void _updateUser(User user) {
    //rebuild widget because we update user. the build method will be rerun
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user != null && _user.uid.isNotEmpty
        ? HomePage(
            auth: widget.auth,
            //send call back function to sign out
            onSignOut: () => _updateUser(null),
          )
        : SignInPage(
            auth: widget.auth,
            //send call back function to sign in
            onSignIn: _updateUser,
          );
  }
}
