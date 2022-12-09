import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {

  CustomSignInButton({super.key,  required this.buttonColor , required  this.onPressed , required this.child});

  final VoidCallback? onPressed;
  final Widget child;
  final Color buttonColor;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, child: child,
    style: ElevatedButton.styleFrom( backgroundColor: buttonColor ),);
  }
}
