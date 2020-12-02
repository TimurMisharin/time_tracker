import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/services/auth.dart';

//sign in page widget
class SignInPage extends StatelessWidget {
  SignInPage({Key key, @required this.bloc}) : super(key: key);

  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPage(bloc: bloc),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _singInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print('_singInAnonymously exception: ${e.toString()}');
    }
  }

  Future<void> _singInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print('_singInWithGoogle exception: ${e.toString()}');
    }
  }

  Future<void> _singInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
      print('_singInWithFacebook exception: ${e.toString()}');
    }
  }

  void _signInWithEmail(BuildContext context) {
    //show email sign in page
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true, // page come from bottom
        builder: (context) => EmailSignInPage(),
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
      body: StreamBuilder<bool>(
          stream: bloc.isLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.blueGrey[100],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      //container child can be any widget in flutter
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.0,
              child: _buildHeader(isLoading),
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
              onPressed: isLoading ? null : () => _singInWithGoogle(context),
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: 'Facebook',
              assertName: 'images/facebook-logo.png',
              textColor: Colors.white,
              color: Color(0XFF334D92),
              onPressed: isLoading ? null : () => _singInWithFacebook(context),
            ),
            SizedBox(
              height: 8.0,
            ),
            SocialSignInButton(
              text: 'email',
              assertName: 'images/mail-logo.png',
              textColor: Colors.black87,
              color: Colors.white70,
              onPressed: isLoading ? null : () => _signInWithEmail(context),
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
              onPressed: isLoading ? null : () => _singInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return //sing in text
        Text(
      'Sign In',
      textAlign: TextAlign.center,
      //style text
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
    );
  }
}
