import 'package:flutter/material.dart';
import 'package:timetracker/CustomWIdgets/CustomSIgnInButton.dart';

class SocialSignInButton extends CustomSignInButton{

  SocialSignInButton({super.key,
    required Color Buttoncolor,
    required String text,
    required String asset,
    required Color Fontcolor,
    required VoidCallback onPressed,
}):super(onPressed: onPressed  ,buttonColor: Buttoncolor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(asset),
        Text(text,style: TextStyle(
          color: Fontcolor,
        ),),
        Opacity(opacity: 0.0,
        child: Image.asset(asset),),

      ],
    ),
  );

}