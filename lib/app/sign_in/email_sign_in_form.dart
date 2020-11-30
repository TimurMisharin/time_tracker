import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/validators.dart';
import 'package:time_tracker_flutter/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter/services/auth.dart';

enum EmailSignInFormType { singIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.singIn;
  bool _submitted = false;
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      if (_formType == EmailSignInFormType.singIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(context,
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    //move to password
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.singIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.singIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: showErrorText ? widget.invalidPasswordErrorText : null,
          enabled: !_isLoading),
      obscureText: true,
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      // login
      onEditingComplete: _submit,
      onChanged: (_password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: !_isLoading,
      ),
      controller: _emailController,
      focusNode: _emailFocusNode,
      autocorrect: false,
      // autocomplete is disabled
      keyboardType: TextInputType.emailAddress,
      //show email keyboard
      textInputAction: TextInputAction.next,
      // on done is moved to password
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.singIn
        ? 'Sign in'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.singIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

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
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        onPressed: !_isLoading ? _toggleFormType : null,
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

  void _updateState() {
    setState(() {});
  }
}
