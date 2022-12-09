import 'package:flutter/material.dart';
import 'package:timetracker/CustomWIdgets/CustomSIgnInButton.dart';

class SignInButton extends CustomSignInButton{

  SignInButton(
  {
      required Color buttonColor,
      required String text,
      required Color fontColor,
      required  VoidCallback onPressed,
   }
      ):super(buttonColor: buttonColor,child: Text(text,
    style: TextStyle(color: fontColor,),
  ), onPressed: onPressed );

}
