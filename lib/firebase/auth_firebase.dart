import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile_home_travel/routers/router.dart';

Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
  print(googleUser?.displayName);
  router.go(RouteName.navigator);
}

Future SignOutGoogle() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  googleSignIn.disconnect();
  await FirebaseAuth.instance.signOut();
  print("Signout success");
  router.go(RouteName.login);
}
