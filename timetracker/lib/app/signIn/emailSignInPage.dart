import 'package:flutter/material.dart';
import 'package:timetracker/app/signIn/emailSignInForm.dart';
import 'package:timetracker/services/auth.dart';


class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
            child: EmailSignInForm(auth: auth,)),
      ),
      backgroundColor: Colors.grey[200],
    );
  }




}
