import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assertName, //must be included
    @required String text, //must be included
    Color color,
    Color textColor,
    @required VoidCallback onPressed, //must be included
  })  : assert(text != null && assertName != null),
        //stop execution if a boolean condition is false, available only on debug mode
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                assertName,
              ),
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
