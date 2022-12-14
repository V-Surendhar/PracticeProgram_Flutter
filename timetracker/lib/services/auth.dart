import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {

  Future<void> signOut();
  Future<User?> signInWithGoogle();
  Stream<User?> authStateChanges();
  Future<User?> signInWithFacebook();
  Future<User?> signInAnonymously();
  Future<User?> createUserWithEmailPassword(String email , String password);
  Future<User?> signInWithEmailAndPassword(String email , String password);
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;


  @override
  Future<User?> signInWithEmailAndPassword(String email , String password) async{

    final userCredential = await _firebaseAuth.signInWithCredential(
        EmailAuthProvider.credential(email: email, password: password)
    );
    return userCredential.user;

  }

  @override
  Future<User?> createUserWithEmailPassword(String email , String password) async{

    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    return userCredential.user;

  }


  @override
  Future<void> signOut() async {

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();

  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null) {
        final userCredentials = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken));
        return userCredentials.user;
      } else {
        throw FirebaseAuthException(
            code: "ERROR_MISSING_GOOGLE_ID_TOKEN",
            message: "Missing Google ID Token");
      }
    } else {
      throw FirebaseAuthException(
          code: "ERROR_ABORTED_BY_USER", message: "Sing in aborted by user");
    }
  }

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User?> signInWithFacebook() async{

    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch(response.status){
      case FacebookLoginStatus.success:
        final accesToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential( accesToken!.token),
        );
        return userCredential.user;

      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(code: "ERROR_ABORTED_BY_USER",
            message: "Sign in aborted by user");

      case FacebookLoginStatus.error:
        throw FirebaseAuthException(code: "ERROR_FACEBOOK_LOGIN_FAILED",
            message: response.error?.developerMessage);

      default:
        throw UnimplementedError();

    }

  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}
