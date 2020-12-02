import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter/services/auth.dart';

/**
 * Sign In page BLoC
 */
class SignInBloc {
  SignInBloc({@required this.auth});

  final AuthBase auth;

  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  //remove from the widget tree
  void dispose() {
    _isLoadingController.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      setIsLoading(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async => _signIn(auth.signInWithFacebook);
}
