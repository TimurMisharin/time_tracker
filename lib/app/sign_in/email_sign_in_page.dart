import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //app layout
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        //shadow of appBar
        elevation: 2.0,
      ),
      //body of widget
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm(),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[100],
    );
  }
}
