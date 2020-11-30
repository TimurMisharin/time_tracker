import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/landing_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';

//entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); //waiting when initializeApp future is completed
  runApp(TrackerApp());
}

//root widget
class TrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
