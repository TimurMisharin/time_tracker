import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 5.0,
    this.height: 50.0,
    this.onPressed,
  }) : assert(borderRadius != null && height != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              borderRadius,
            ),
          ),
        ),
        //if is null button is disabled
        onPressed: onPressed,
      ),
    );
  }
}
