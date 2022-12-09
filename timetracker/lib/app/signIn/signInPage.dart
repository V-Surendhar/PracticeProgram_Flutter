import 'package:flutter/material.dart';
import 'package:timetracker/app/signIn/SocialSignInButton.dart';
import 'package:timetracker/app/signIn/emailSignInPage.dart';
import 'package:timetracker/app/signIn/signInButton.dart';
import 'package:timetracker/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);

  final AuthBase auth;

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInAnonymoulsy() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }


  void _siginInWithEmail(BuildContext context){

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth,),
      ),
    );

  }


  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Tracker"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Sign in",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 40,
            ),
            SocialSignInButton(
                Buttoncolor: Colors.white,
                text: "Sign in with Google",
                asset: "assets/google-logo.png",
                Fontcolor: Colors.black87,
                onPressed:_signInWithGoogle),
            const SizedBox(
              height: 8,
            ),
            SocialSignInButton(
                Buttoncolor: Color(0xFF334D92),
                text: "Sign in with Facebook",
                asset: "assets/facebook-logo.png",
                Fontcolor: Colors.white,
                onPressed: _signInWithFacebook),
            const SizedBox(
              height: 8,
            ),
            SignInButton(
                buttonColor: Color(0xFF00796B),
                text: "Sign in with email",
                fontColor: Colors.white,
                onPressed: () => _siginInWithEmail(context)),
            const Text(
              "or",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            SignInButton(
                buttonColor: Color(0xFFDCE775),
                text: "Go Anonymous",
                fontColor: Colors.black87,
                onPressed: _signInAnonymoulsy),
          ],
        ),
      ),
    );
  }
}
