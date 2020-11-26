import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/sign_in/sign_in_page.dart';

//entry point
Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //waiting when initializeApp future is completed
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
        home: SignInPage());
  }
}
