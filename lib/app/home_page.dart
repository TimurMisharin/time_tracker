import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, @required this.auth, @required this.onSignOut})
      : super(key: key);

  final VoidCallback onSignOut;

  final AuthBase auth;

  Future<void> _singOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print('_singInAnonymously exception: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          FlatButton(
            onPressed: _singOut,
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 18.0, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}