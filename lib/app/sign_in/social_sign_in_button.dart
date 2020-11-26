import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assertName,
    @required String text,
    Color color,
    Color textColor,
    @required VoidCallback onPressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(assertName),
              Text(
                'Sing in with $text',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.0,
                ),
              ),
              Opacity(
                child: Image.asset(assertName),
                opacity: 0.0,
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
