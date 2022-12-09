import 'package:timetracker/CustomWIdgets/CustomSIgnInButton.dart';
import 'package:flutter/material.dart';

class FormSubmitButton extends CustomSignInButton {

  FormSubmitButton({
    required String text,
    required VoidCallback? onPressed,
  }) :super(
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0),),
    buttonColor: Colors.indigo,
    onPressed: onPressed,
  );
}

