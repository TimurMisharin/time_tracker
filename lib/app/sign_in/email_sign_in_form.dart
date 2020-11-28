import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/services/auth.dart';

enum EmailSignInFormType { singIn, register }

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;

  EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.singIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.singIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print('_submit ${e.toString()}');
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.singIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.singIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  TextField _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      controller: _passwordController,
      autocorrect: false,
      textInputAction: TextInputAction.done, // login
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
      ),
      controller: _emailController,
      autocorrect: false,
      // autocomplete is disabled
      keyboardType: TextInputType.emailAddress,
      //show email keyboard
      textInputAction: TextInputAction.next, // on done is moved to password
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.singIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.singIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(secondaryText),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // how a column will take from a page
        children: _buildChildren(),
      ),
    );
  }
}
