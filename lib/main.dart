import 'package:flutter/material.dart';

import 'app/sign_in/sign_in_page.dart';

//entry point
void main() {
  runApp(TrackerApp());
}

//root widget
class TrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SignInPage()
    );
  }
}
